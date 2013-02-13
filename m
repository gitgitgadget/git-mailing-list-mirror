From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: Re: [PATCH v2 2/3] t9903: add tests for bash.showUntrackedFiles
Date: Wed, 13 Feb 2013 18:27:41 +0100
Message-ID: <1360776461.13768.8.camel@mas>
References: <1360753138.25490.10.camel@mas>
	 <1360753321-5002-1-git-send-email-martinerikwerner@gmail.com>
	 <1360753321-5002-2-git-send-email-martinerikwerner@gmail.com>
	 <7v621wb2sp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, trsten@science-computing.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 18:28:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5g7u-0006Ek-AB
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 18:28:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934313Ab3BMR1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 12:27:46 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:60355 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759726Ab3BMR1q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 12:27:46 -0500
Received: by mail-lb0-f178.google.com with SMTP id n1so1135083lba.9
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 09:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:x-mailer:mime-version
         :content-transfer-encoding;
        bh=ESPIstDXawMOw2F2sf0HV6NpBBnxfxrVvNzOGxTFZuw=;
        b=NkhcSg4egDU66UkSGib8cGoqQH9IO5/x6hA1xFbAhtsPW3RsdFGFuw8DRRIvPp1qUS
         QOlgEKlz9v2G4v46sVRHDHgRa33ETKQl0rsUKgnm9i0GpuiYlyOxmCPa5gqFjxZjN3H9
         4Wvv1yz0GsXkRSVWpmwO7eDgX44wb/xPDXqIFCAM8JWAnm4Rn+r423rNVH6KUSdDTgzQ
         AED5v8Cg6amvLpUsIAPXER78DRkuN3e2g5Wdx6AnA/4W8Dnh3bWdQQoYLEl0pYveI2EQ
         nzD+/fMJRNEKXTQFXnF+d58Ye2TDHJfwjN0zc+Pr6aAAgJP4vzTsRpVySbXykXQO0My/
         CvLQ==
X-Received: by 10.112.23.34 with SMTP id j2mr9051536lbf.118.1360776464340;
        Wed, 13 Feb 2013 09:27:44 -0800 (PST)
Received: from [192.168.1.2] (nl107-187-0.student.uu.se. [130.243.187.0])
        by mx.google.com with ESMTPS id iw6sm26133540lab.2.2013.02.13.09.27.42
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 09:27:43 -0800 (PST)
In-Reply-To: <7v621wb2sp.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.6.1-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216273>

On Wed, 2013-02-13 at 08:23 -0800, Junio C Hamano wrote:
> Martin Erik Werner <martinerikwerner@gmail.com> writes:
> 
> > Add 4 test for the bash.showUntrackedFiles config option, covering all
> > combinations of the shell var being set/unset and the config option
> > being enabled/disabled.
> >
> > Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
> > ---
> >  t/t9903-bash-prompt.sh |   40 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> > index f17c1f8..cb008e2 100755
> > --- a/t/t9903-bash-prompt.sh
> > +++ b/t/t9903-bash-prompt.sh
> > @@ -437,6 +437,46 @@ test_expect_success 'prompt - untracked files status indicator - untracked files
> >  	test_cmp expected "$actual"
> >  '
> >  
> > +test_expect_success 'prompt - untracked files status indicator - shell variable unset with config disabled' '
> > +	printf " (master)" > expected &&
> > +	test_config bash.showUntrackedFiles false &&
> > +	(
> > +		unset -v GIT_PS1_SHOWUNTRACKEDFILES &&
> 
> We do not use "unset -v" anywhere else in our system.  Shells
> mimicking SysV may choke on it.  A Portable POSIX script can omit
> "-v" when unsetting a variable.
> 
> Also "unset" can return false when the variable is not set to begin
> with with some shells.
> 
> Neither of these matters for this particular case because we know we
> are running this under bash in non-posix mode.  I however wonder if
> we can do something to prevent careless coders to copy and paste
> this piece when updating other tests that are not limited to bash.
> Commenting each and every use of "unset -v" does not sound like a
> good solution and perhaps I am being unnecessarily worried too much.
> 

Yeah, my (ba)sh foo is a bit limited, I was just basing on
http://wiki.bash-hackers.org/commands/builtin/unset#portability_considerations which seemed to recommend using -v.

So would it make sense to do:
	GIT_PS1_SHOWUNTRACKEDFILES="dummy" &&
	unset GIT_PS1_SHOWUNTRACKEDFILES &&
	(...)
instead then?

-- 
Martin Erik Werner <martinerikwerner@gmail.com>
