From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH/RFC/WIP/POC] git-gui: grep prototype
Date: Fri, 19 Nov 2010 13:15:44 +0100
Message-ID: <AANLkTimWyjrRD951AGeEayMoTNd-N2OXRd_wQ0RBFegN@mail.gmail.com>
References: <1289770869-11665-1-git-send-email-bert.wesarg@googlemail.com>
	<20101114215442.GC16413@burratino>
	<AANLkTiktg4aZ7VfdXUT9XF4RK7MuCvzevB5jSRaNiE1L@mail.gmail.com>
	<20101114220932.GE16413@burratino>
	<AANLkTi=JR3vVnZ4Yz8o9MpZKiQ2_ASYxahbPNv8QACir@mail.gmail.com>
	<20101114234848.GB26104@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	"Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 13:15:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJPsg-0005hK-Vq
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 13:15:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754055Ab0KSMPq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Nov 2010 07:15:46 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58022 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754101Ab0KSMPp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Nov 2010 07:15:45 -0500
Received: by gwj17 with SMTP id 17so2602889gwj.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 04:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bxqr0343DNc1ASO2WAAOx9bMMrzrp2XGAMu8WE/pxZ8=;
        b=SIpcXmBNCnrGNxCZ8VgiNqCgG10ZE+KmVS4Eb8mcujnLKb+eF8TwJWrJTAV5Re2lbY
         HHDZaQJbwmAtfVHpI55DJo+A14V9CBZs6uiPL/ftVt5otvKS3pdTiWW4VggM1R1r3TBX
         z0TNIf6I9yk905cJdb65qsy2RIWm24YPrLWhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=w/m7y30/HYRDXo3SD2UxhB/HJpCvOezBEvB4Us03q94Hs4mrnLos3DrSIixAne81oX
         oA3plyhDwYHuVPIQylPunfXqEV0DMfjjcs42d0zOMnrkjwHVx73s6oScZLA5GaQHPcVe
         Qbfp8OkloxLLr3+xUe+HK5NIsSDn56cG8nF1E=
Received: by 10.42.207.202 with SMTP id fz10mr202700icb.374.1290168944414;
 Fri, 19 Nov 2010 04:15:44 -0800 (PST)
Received: by 10.42.14.70 with HTTP; Fri, 19 Nov 2010 04:15:44 -0800 (PST)
In-Reply-To: <20101114234848.GB26104@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161744>

On Mon, Nov 15, 2010 at 00:48, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Bert Wesarg wrote:
>
>> Now I got your point. Maybe I should call GIT_EDITOR with $FILENAME =
as
>> argument but with a new variable to indicate open'n'forget. So
>> existing setups would always open the file (even without honoring th=
e
>> line number) and new/smart wrappers can honor the open'n'forget and
>> line number flag.
>
> Yes, I like the communication-via-environment idea.
>
> In fact, there are multiple questions an editor might want answered:
>
> 1. GUI or no GUI? =C2=A0(The combination of $DISPLAY and $(tty) often
> =C2=A0 yields a reasonable answer.)

I think we can generalize this by using the name of the caller (ie
binary name). This is easy to get in a unix/linux shell with the help
of /proc/$PPID/exe, but maybe not so in others OS's. I just remembered
that quilt has this feature, the name is QUILT_COMMAND and I use is in
my wrapper script to detect whether the caller wants to wait or not (I
block only on the header and mail command).

>
> 2. open'n'forget or wait for answer? =C2=A0(gvim's --nofork option)
>
> 3. What line number?
>
> 4. regex to use to highlight matches?
>
> Ideally $LINENUMBER would only be used represent (3), while a
> separate variable would indicate (2).
>

Using for each case its own flag may sound silly, but I think this
makes it more clear, what the caller expects.
=46or example in my git-patch for calling GIT_EDITOR I provide a flag
whether the given path is in the index or not (ie the action comes
from the index list). If it is from the index, I use checkout-index
--temp and update-index to edit the content from the index. This call
to GIT_EDITOR should be blocking but it is better to request this
explicitly.

Could we settle on a name space for such variables? GIT_EDITOR_* makes
it obvious that it is for the editor started from git.

Bert
