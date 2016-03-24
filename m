From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Resumable git clone?
Date: Thu, 24 Mar 2016 08:00:08 -0000
Organization: OPDS
Message-ID: <C59B0CDA60BC402B900305A9D62D815B@PhilipOakley>
References: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com> <xmqqziuh46hb.fsf@gitster.mtv.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>, <sarah@thesharps.us>,
	<viro@zeniv.linux.org.uk>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Josh Triplett" <josh@joshtriplett.org>,
	"Konstantin Ryabitsev" <konstantin@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 24 09:00:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj0Bk-0001DX-6X
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 09:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbcCXIAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 04:00:13 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:64779 "EHLO
	smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbcCXIAL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 04:00:11 -0400
Received: from PhilipOakley ([92.22.21.19])
	by smtp.talktalk.net with SMTP
	id j0BaaWTokEnBtj0BaaKoA9; Thu, 24 Mar 2016 08:00:08 +0000
X-Originating-IP: [92.22.21.19]
X-Spam: 0
X-OAuthority: v=2.1 cv=YNU/sUyx c=1 sm=1 tr=0 a=I7bjfyOo2Kke1IIJyMFemw==:117
 a=I7bjfyOo2Kke1IIJyMFemw==:17 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10
 a=s5jvgZ67dGcA:10 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8 a=UPm3pfgAAAAA:8
 a=zBK5yZjOAAAA:8 a=VwQbUJbxAAAA:8 a=KOwJaKI2jVH_R5H-zDcA:9 a=wPNLvfGTeEIA:10
 a=x8gzFH9gYPwA:10
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfHJfZhRq9/b5CYQCmQ8OZiqmdzSTdGouyDVS1hz0qkjFXedW0chzqBrNNsoxN7Wq0YePOZJjFDfmuxfacmJ7tOjAliaUkdkrhnIVm6CUp8WnyFeX2tY4
 symxrfbcmadrQeGe8UmPT8ckCuv53i4+kIPBhZ73TGlr1bsF4fjak/3WXzlMFD0aySBwSx7wCzVxNQkusfGLyB7oR5cbMDOFhCrP44D1755vfNlACsvr2vb0
 NtsqJALnWHoRfXLJmqnCOZaYc8G3NygQrf8rNCQICB6zldPiaMqZGXcY1yZKkhRTjW5dtUtne9QzErJf8FVO0fN8XRw/7HMmunEfgOVFX6Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289722>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Wednesday, March 02, 2016 8:41 AM
> Josh Triplett <josh@joshtriplett.org> writes:
>
>> If you clone a repository, and the connection drops, the next attempt
>> will have to start from scratch.  This can add significant time and
>> expense if you're on a low-bandwidth or metered connection trying to
>> clone something like Linux.
>
> For this particular issue, your friendly k.org administrator already
> has a solution.  Torvalds/linux.git is made into a bundle weekly
> with
>
>    $ git bundle create clone.bundle --all
>

Isn't this use of '--all' a bit of oversharing? I had proposed a doc patch
to the bundle manpage way back (see $gmane/205897) to give the
user that example, but it wasn't accepted as it was thought wrong.

" I also think "--all" is a bad advice for another reason.  Doesn't it
shove refs from refs/remotes/* hierarchy in the resulting bundle?
It is fine for archiving purposes, but it does not seem to be a good
advice to create a bundle to clone from."

Perhaps the '--clone-bundle' (or maybe'--bundle-clone') option from 
$gmane/288222  [PATCH] index-pack: --clone-bundle option 2016-03-03 maybe a 
suitable new <rev-list-arg> to get just the right content?

> and the result placed on k.org CDN.  So low-bandwidth cloners can
> grab it over resumable http, clone from the bundle, and then fill
> the most recent part by fetching from k.org already.
>
> The tooling to allow this kind of "bundle" (and possibly other forms
> of "CDN offload" material) transparently used by "git clone" was the
> proposal by Shawn Pearce mentioned elsewhere in this thread.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
