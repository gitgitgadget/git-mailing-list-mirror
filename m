From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Bulgarian translation of git
Date: Mon, 13 Feb 2012 08:00:36 -0600
Message-ID: <20120213133957.GA4838@burratino>
References: <75009f1d7c4aba4d62bb226ab122932c@192.168.122.10>
 <CANYiYbGr3zN-kJwq_MCnttNZP6Cc0aj-fsZjd4V=4z+BA5TvUw@mail.gmail.com>
 <7vy5s7idxb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Alexander Shopov
	 =?utf-8?B?KNCQ0LvQtdC60YHQsNC90LTRitGAINCo0L7Qv9C+?=
	 =?utf-8?B?0LIp?= <lists@kambanaria.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 15:01:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwwSv-0003YZ-3G
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 15:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361Ab2BMOAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 09:00:46 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55103 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178Ab2BMOAp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 09:00:45 -0500
Received: by iacb35 with SMTP id b35so4427389iac.19
        for <git@vger.kernel.org>; Mon, 13 Feb 2012 06:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=R+kuJjpbAmB+/4ErHA+vN5izOEclRYurE9n+TyVEF0g=;
        b=azMvnxEBgTP1kukwPJhsxvUsLM9eF8c7mg3++eZndKK48LEkByo3+zPiTT+SVQC6Jc
         lt4jCCsNZnUsOGFvP0ICkVoWG5VH7wuWz1b0JR1hdOl0cgx65q2V38I4O9q/WHVxsUFg
         91GECOUf0bPbs00LmEQg46dnK/s7BQn73Rz9k=
Received: by 10.42.19.65 with SMTP id a1mr21581613icb.48.1329141644645;
        Mon, 13 Feb 2012 06:00:44 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id k3sm14091372igq.1.2012.02.13.06.00.43
        (version=SSLv3 cipher=OTHER);
        Mon, 13 Feb 2012 06:00:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vy5s7idxb.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190627>

Junio C Hamano wrote:
> Jiang Xin <worldhello.net@gmail.com> writes:

>> I have a question, which version of po should be maintained? master
>> branch or maint branch.
>
> I would say for this round the git-po repository and its pot file should
> pick up whatever new translatable strings are added to 'master'.
>
> After this is merged in 1.7.10, we may want to maintain separate tracks,
> but at this moment there is no point maintaining something mergeable to
> 1.7.9.x maintenance track.

I wonder if there's a simple to ask the gettext tools to make a po
template including strings from both 'maint' and 'master'.  (Hackish way
demonstrated below.)

Hopefully that would make it easier for translators to keep both
tracks well maintained at the same time.  If a problem in the
translation of a string shared by 'master' and 'maint' is only noticed
while working on 'master', there would be no need to go through the
"switch branches; make the change; switch back; merge" dance.

What do you think?
Jonathan

diff --git i/Makefile w/Makefile
index 1e91b19c..5dbc6205 100644
--- i/Makefile
+++ w/Makefile
@@ -2103,7 +2103,8 @@ LOCALIZED_C := $(C_OBJ:o=c)
 LOCALIZED_SH := $(SCRIPT_SH)
 
 po/git.pot: $(LOCALIZED_C)
-	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)
+	cp $@ $@+
+	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)
 	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_SH) \
 		$(LOCALIZED_SH)
 	mv $@+ $@
