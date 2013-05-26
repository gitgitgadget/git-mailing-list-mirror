From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 2/4] fetch-pack: prepare updated shallow file before
 fetching the pack
Date: Sun, 26 May 2013 08:01:33 +0700
Message-ID: <CACsJy8BFbDA1MitnktL6tNy59sWMw4vnsZ0wN6UfDfY_oAKh+w@mail.gmail.com>
References: <1367405974-22190-1-git-send-email-pclouds@gmail.com>
 <1367584514-19806-1-git-send-email-pclouds@gmail.com> <1367584514-19806-3-git-send-email-pclouds@gmail.com>
 <7va9o6lr0h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 26 03:02:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgPLg-0003gx-CJ
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 03:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758556Ab3EZBCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 21:02:08 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:52443 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758476Ab3EZBCG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 May 2013 21:02:06 -0400
Received: by mail-ob0-f169.google.com with SMTP id up14so352409obb.28
        for <git@vger.kernel.org>; Sat, 25 May 2013 18:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fOEe9M6JNJ1BC4Ap5GPxP9oq3Ky/TX5z0HogIq/lAz8=;
        b=PScmYWPOeRNc/nILnYarNYYdU9J9geOr5JukH0HprZ6pXs9llSPzez2HaKYyJzpYJ6
         TjfJOBxrbOD3jEp94g6ryGXlo03r3vq08EY1INWgyMqNdRD7OnaseD/qpSJJeTtuxl93
         t3QNRrbHI9V9CxpIyjgbxxJTuQxFTS11sChcrHpxiDKt1r3HpSzrFkl9aMA2LimYh0UX
         4pWyPwkjXrC2ubOA/90b6JhTNZmkCpfNbzDjlI0pemLxdqxjjXkeJSFe72QSOuHh/DwN
         gpBQaDvGFv7klTg0gnxazMCxG98Nn2JEG6Gz/vzqgCm2x6Wn5hgbr421plvO6cOB+L36
         QLcA==
X-Received: by 10.60.134.147 with SMTP id pk19mr15821184oeb.4.1369530124939;
 Sat, 25 May 2013 18:02:04 -0700 (PDT)
Received: by 10.76.141.232 with HTTP; Sat, 25 May 2013 18:01:33 -0700 (PDT)
In-Reply-To: <7va9o6lr0h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225536>

On Tue, May 7, 2013 at 10:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>       if (args->depth > 0) {
>> +             struct stat st;
>> +             if (!fstat(shallow_lock.fd, &st) &&
>> +                 st.st_size == 0) {
>> +                     unlink_or_warn(git_path("shallow"));
>
> Are we unlinking the right file here?

Yes we are. when st.st_size is 0, the new shallow file is empty (i.e.
--unshallow), so we want to remove the old file. I should check
"!*alternate_shallow_file" here instead of based on st.st_size.
--
Duy
