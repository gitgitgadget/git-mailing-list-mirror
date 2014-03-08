From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] upload-pack: send shallow info over stdin to pack-objects
Date: Sat, 8 Mar 2014 07:08:05 +0700
Message-ID: <CACsJy8AcYBXi6LjyJDeEnogPTXfqYXqijXaLY=bUgNnd4cT_Fg@mail.gmail.com>
References: <1393936205-15953-1-git-send-email-pclouds@gmail.com>
 <1394095783-24402-1-git-send-email-pclouds@gmail.com> <xmqqfvmvyxzv.fsf@gitster.dls.corp.google.com>
 <CACsJy8B8=N6R6nVa12jjhxdqxMA2eGXOV6jR-XqRRbb-6Xppdg@mail.gmail.com> <xmqq8uslvp86.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 08 01:09:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM4p3-0005Tw-R2
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 01:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbaCHAIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 19:08:36 -0500
Received: from mail-qa0-f43.google.com ([209.85.216.43]:54927 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbaCHAIg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 19:08:36 -0500
Received: by mail-qa0-f43.google.com with SMTP id j15so4782044qaq.16
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 16:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SRrNVT3nY4WfOyR2T4Oz1XS5vAgPf3NWtYJhoKPb4CE=;
        b=DiAAMDp28IsTu+vhtR/QJwmh1NK4oU10Ez+X4zVHWxvj48Xy41HvYHNpFSCvVsLddM
         ox/OcDZzZItUvDDKoU/wBjZqp8uU06pnJ/1AQvIW5Mk3xQvILQDMFO0UjrzbC0lOo84r
         oC5FjxkT5WIoMsbC8KMAMYld3o44K5hjFbE0b67mNNzeLYaJ2u/mGQvasSVRxTGn94QU
         vKiYVUJm8ssdHUZT9UbLhvOApC6RcUZsN1RAB18gZx3YkFMPHIrLFtecY7ca2PlEWZ1F
         hGrWCWK2SchH1PqcVLWCVteRTUzOFV/NmoXUJLCEls/XtEy5VNbO5e3u93Dq0joC5jNC
         NTCw==
X-Received: by 10.224.26.71 with SMTP id d7mr25543876qac.89.1394237315179;
 Fri, 07 Mar 2014 16:08:35 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Fri, 7 Mar 2014 16:08:05 -0800 (PST)
In-Reply-To: <xmqq8uslvp86.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243638>

On Sat, Mar 8, 2014 at 1:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> On the receive-pack side, the comment at the bottom of
>>> preprare_shallow_update() makes it clear that, if we wanted to use
>>> hooks, we cannot avoid having the proposed new shallow-file in a
>>> temporary file, which is unfortunate.  Do we have a similar issue on
>>> hooks on the upload-pack side?
>>
>> No. I don't think we have hooks on upload-pack.
>
> The question was not only about "do we happen to work OK with the
> current code?" but about "are we closing the door for the future?"
>
> If we ever need to add hooks to upload-pack, with the updated
> approach, its operation will not be affected by the temporary
> shallow file tailored for this specific customer.  Which I think is
> a good thing in general.
>
> But at the same time, it means that its operation cannot be
> customized for the specific customer, taking into account what they
> lack (which can be gleaned by looking at the temporary shallow
> information).  I do think that it is not a big downside, but that is
> merely my knee-jerk reaction.

When upload-pack learns about hooks, I think we'll need to go back
with --shallow-file, perhaps we a secure temporary place to write in.
I don't see another way out. Not really sure why upload-pack needs
customization though. The only case I can think of is to prevent most
users from fetching certain objects, but that does not sound
realistic..

>>> Nothing for Documentation/ anywhere?
>>
>> Heh git-pack-objects.txt never described stdin format. At least I
>> searched for --not in it and found none. So I gladly accepted the
>> situation and skipped doc update :D
>
> To pile new technical debt on top of existing ones is to make things
> worse, which we would rather not to see.

Of course.. So what should we do with this? Go with this "no temp
file" approach and deal with hooks when they come, or prepare now and
introduce a secure temp. area?
-- 
Duy
