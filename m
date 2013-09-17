From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: RFC: git bisect should accept "paths-to-be-excluded"
Date: Tue, 17 Sep 2013 18:45:00 +0700
Message-ID: <CACsJy8AEoUUat-1smJ1BmDuDBLseWf8oZ+EJyuadSLncb1UMSw@mail.gmail.com>
References: <5236FBEA.80909@gmx.de> <CAP8UFD0qC3UM3Dgt2dhpcBHt34yZ3HwNO6y7Z=EBtyRYpyc+Bw@mail.gmail.com>
 <vpqvc1z6eoo.fsf@anie.imag.fr> <CAP8UFD1u9hPFcbftpacDFdp27Jmp0YLGbpHPP12uEtjzEmnPQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 13:45:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLtip-0000Ri-Jp
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 13:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849Ab3IQLpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 07:45:32 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:47266 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492Ab3IQLpb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 07:45:31 -0400
Received: by mail-ob0-f173.google.com with SMTP id vb8so5109262obc.18
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 04:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0eQXydlCpGgUWOWm4gIxM0wLvgxGD4dm/FYo06ywBLs=;
        b=S5bfxIxOxnzVmya8hwdYWrqpDnqPlFX0IsJz5sn/Vh1skbKnYt/aaiNIyKQr/sq6p7
         1dKNd7Lc7l5upflQK1KGQPXfQ3XoioBnlXsxIlkdODW1mhHYasQnnFt/iCpkRTDxuiz5
         gnVijYfeMNXeDsvBX02LL4PKoGRSVCbgCm+beoJl8Z6er/2ZP4YhOYPfmm81HJBMYfBB
         7rcfnx2ktY48m1bOzx1V+U3LFHabOw5Zkh+EGGYZYBW68HQoB2dusoopQpJGMl7XkQxm
         PUoprD4mHTNSeGIB9FZqDIQGy4jROBuytunEBP19QHrasHPpWh4VK0ru8RJ3SufPysbC
         7UBg==
X-Received: by 10.60.93.67 with SMTP id cs3mr30035986oeb.12.1379418330716;
 Tue, 17 Sep 2013 04:45:30 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Tue, 17 Sep 2013 04:45:00 -0700 (PDT)
In-Reply-To: <CAP8UFD1u9hPFcbftpacDFdp27Jmp0YLGbpHPP12uEtjzEmnPQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234873>

On Tue, Sep 17, 2013 at 4:03 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Tue, Sep 17, 2013 at 10:21 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>>> In practice though, as git bisect is a kind of binary search, if what
>>> you want to exclude is exclusively touched by half the commits, it
>>> will only add one more bisection step if you don't exclude it.
>>
>> Actually, I think the same remark would apply to any other Git command
>> that deal with a set of revisions. If you want to review code with "git
>> log -p", but you don't care about a subdirectory, you may want a "git
>> log -p --ignore-dir foo/" or so, too.
>
> Yeah, and there was a patch series about that 2 years ago:
>
> http://thread.gmane.org/gmane.comp.version-control.git/182830/

And that's just one of the few attempts if I remember correctly. I
guess it's time revisit it. A few things to sort out before we get to
the implementation:

Support flat or nested negation (i.e.include A, ignore A/B, but
include A/B/C..). Nested thing complicates things so I'm towards the
flat exclusion (exclude B means all inside B, no buts nor excepts) and
probably cover most use cases

Interaction with "git grep --depth"

Syntax. I guess --ignore (or --exclude) is more intuitive than
":(exclude)something" but then it might collide with existing options
(I did not check if --ignore or --exclude is used anywhere though).
The latter also enables combining with other filters, such as
case-insensitive matching..
-- 
Duy
