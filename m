From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v3 2/3] mergetool: don't require a work tree for
 --tool-help
Date: Tue, 14 Oct 2014 23:48:26 -0700
Message-ID: <20141015064824.GD14751@gmail.com>
References: <1413016778-94829-1-git-send-email-davvid@gmail.com>
 <1413016778-94829-2-git-send-email-davvid@gmail.com>
 <xmqqsiir3hlk.fsf@gitster.dls.corp.google.com>
 <20141015063509.GB14751@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>,
	Charles Bailey <cbailey32@bloomberg.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 08:48:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeINY-0000g7-Fc
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 08:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbaJOGsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 02:48:08 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32993 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbaJOGsG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 02:48:06 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq14so736112pab.26
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 23:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=p7zSQvQcthG2Jk1rOpAppG/JyjTggVaYAN1k4VPxoqQ=;
        b=maya6OkaFszdlZmkaLUc/+TJGmKTN6UM4QoUuOrW4WMbyku6Rhjd+QeYZWbkwSHRFM
         dHZanmzCBDnIQtnwiE0jYFEEp9nOIGEhzysN/Jvhm27rKrDYa7PsQAh6vE7D3/UVHc3c
         VwbRpf/FVYabo0jm+rXH9v998KkQCIWfqUce5uPRfjJ284BsHEx9Wbkvvpo/Jb/b48mD
         givpSO1Ygpu4/WoMl8SwXihiuOf37dEipbzQ8VWsccBscES8wNRGTh9SK9ZrortCQejz
         8XY7ghs0VN9vjSboyqzo+RUoOa5rB/c8kraA0shDcP1ypERsMRD12Upan1I80lGUufPF
         GWBA==
X-Received: by 10.66.66.101 with SMTP id e5mr10237753pat.102.1413355686568;
        Tue, 14 Oct 2014 23:48:06 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id t4sm14232154pbs.86.2014.10.14.23.48.04
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 23:48:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141015063509.GB14751@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 14, 2014 at 11:35:11PM -0700, David Aguilar wrote:
> On Mon, Oct 13, 2014 at 12:16:55PM -0700, Junio C Hamano wrote:
> > David Aguilar <davvid@gmail.com> writes:
> > 
> > > From: Charles Bailey <cbailey32@bloomberg.net>
> > >
> > > Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
> > > Signed-off-by: David Aguilar <davvid@gmail.com>
> > > ---
> > > Changes since v2:
> > >
> > > This now uses the new git_dir_init function.
> > >
> > >  git-mergetool.sh | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/git-mergetool.sh b/git-mergetool.sh
> > > index 96a61ba..cddb533 100755
> > > --- a/git-mergetool.sh
> > > +++ b/git-mergetool.sh
> > > @@ -10,11 +10,11 @@
> > >  
> > >  USAGE='[--tool=tool] [--tool-help] [-y|--no-prompt|--prompt] [file to merge] ...'
> > >  SUBDIRECTORY_OK=Yes
> > > +NONGIT_OK=Yes
> > >  OPTIONS_SPEC=
> > >  TOOL_MODE=merge
> > >  . git-sh-setup
> > >  . git-mergetool--lib
> > > -require_work_tree
> > >  
> > >  # Returns true if the mode reflects a symlink
> > >  is_symlink () {
> > > @@ -378,6 +378,9 @@ prompt_after_failed_merge () {
> > >  	done
> > >  }
> > >  
> > > +require_work_tree
> > > +git_dir_init
> > 
> > This is somewhat curious.  Shouldn't the order of these swapped?
> 
> Yes.  I'll send a replacement patch for 2/3 only.

Nevermind, I noticed you already fixed this up in pu.

Thank you,
-- 
David
