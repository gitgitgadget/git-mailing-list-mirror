From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 0/2] i18n: add ngettext stub
Date: Wed, 9 Mar 2011 04:31:04 -0600
Message-ID: <20110309103104.GA30980@elie>
References: <7vy64u65ta.fsf@alter.siamese.dyndns.org>
 <loom.20110304T210337-216@post.gmane.org>
 <7vtyfi606a.fsf@alter.siamese.dyndns.org>
 <4D7165A3.5080308@colin.guthr.ie>
 <7vlj0u5wyw.fsf@alter.siamese.dyndns.org>
 <4D7223A9.6080105@colin.guthr.ie>
 <7vsjuz520w.fsf@alter.siamese.dyndns.org>
 <7vhbbf50vu.fsf@alter.siamese.dyndns.org>
 <20110306225641.GB24327@elie>
 <AANLkTikctSrfqKCdeYUyvUmAZjr=i7kaFhPeB-LfwgUz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 11:31:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxGfv-0005sp-NQ
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 11:31:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757164Ab1CIKbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 05:31:12 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:43778 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757135Ab1CIKbL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 05:31:11 -0500
Received: by yia27 with SMTP id 27so152882yia.19
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 02:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=F7+iAROCkW01Gj2i5XBefZrR5S8wh/3WQOSeo3l8zNk=;
        b=FGEhSLI1jSjKc88WA1TABHw1nbVoWLYDipIdQ58lVWJ9tSevVjeE/mfrFwDskPRdAu
         N2nwC6JF90WKFj6jYRAqvUG1UdZ+WJSxzjcjS/L1SDcI+NrIGaB52NIofQ+34LPoBjoN
         Ol55djFIAZqhnSD8H5lCJe1Ve+Pi6+63gsCuw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jmMkpIfj7jVuASw1azhPO/XO9ya232rFM5V/CJQTeQvh+vJoo3/kbjPspUl3OByKqp
         f+yg776b1jYFoucZXEwvATqp0kSQrOA8gaoocZETecw5LveZ0jJouYNIIQCfX5UruQu7
         fSFZUZgghACzs787RVHreCforfwet6IGEZjgs=
Received: by 10.150.47.34 with SMTP id u34mr5708989ybu.362.1299666670910;
        Wed, 09 Mar 2011 02:31:10 -0800 (PST)
Received: from elie (adsl-69-209-61-99.dsl.chcgil.sbcglobal.net [69.209.61.99])
        by mx.google.com with ESMTPS id p33sm3187230ybk.2.2011.03.09.02.31.09
        (version=SSLv3 cipher=OTHER);
        Wed, 09 Mar 2011 02:31:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikctSrfqKCdeYUyvUmAZjr=i7kaFhPeB-LfwgUz@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168726>

Junio C Hamano wrote:
> On Mar 6, 2011 3:07 PM, "Jonathan Nieder" <jrnieder@gmail.com> wrote:

>> Yep.  Is it safe to do this without the
>>
>> #define ngettext git_ngettext
>> static inline const char *git_ngettext(...)
>>
>> dance?
>
> Heh you tell me.

Yegh.  My general feeling was that we should make sure gettext.h works
even if <libintl.h> was included elsewhere, just in case some system
header decides to start including it.  That makes life slightly less
pleasant, since libintl.h does

 #if defined __OPTIMIZE__ && !defined __cplusplus
[...]
 # define ngettext(msgid1, msgid2, n) dngettext (NULL, msgid1, msgid2, n)
[...]
 #endif	/* Optimizing.  */

How about this?

Jonathan Nieder (1):
  i18n: avoid conflict with ngettext from libintl

Junio C Hamano (1):
  i18n: add no-op ngettext() fallback

 gettext.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

-- 
1.7.4.1
