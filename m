From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 10/12] ref-filter: introduce remote_ref_atom_parser()
Date: Sun, 7 Feb 2016 00:14:09 +0530
Message-ID: <CAOLa=ZSLbtdi8SxfD8iNEBO_EQUEYWYK2mNgNUjPpJ2qSgGiVQ@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
 <1454262176-6594-11-git-send-email-Karthik.188@gmail.com> <20160205000506.GA6417@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 19:44:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aS7qe-0004Ey-I1
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 19:44:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbcBFSok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2016 13:44:40 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34800 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbcBFSoj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 13:44:39 -0500
Received: by mail-vk0-f67.google.com with SMTP id e6so3436568vkh.1
        for <git@vger.kernel.org>; Sat, 06 Feb 2016 10:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JZkTRoJF263RbRPKioju9++0aJJ/kZntI5sUFtJKOG8=;
        b=g8ICHRUPtRXFD2rp0h0l4gDmNOy1wxDWy1klMCBge8daCwYv1pHJlOG++u28l1w0Mx
         S1vBJQy2aUR7L7sNuETKi35N1egTQgayFS+A7iKEhi05KjoKmIRU1pTkAlWW9hZL/yLE
         yptK9RHwn1L20ZaWNbnLq4KzFMI3rAXTWyPaPMKcmkvG6plB4blgofW4EOket3i2dYtJ
         +tOZHk53SGjeVxpDMPgcb+4MBaNyGsqEbuZL4iXeaX9kP6pWVllnESQmOslkWsEdsqDg
         5E34pixXvGytaWuinSW1E6JLaUJshrysg9E+4yn1om0+wd9TKAxTg2pI1N8rWZpVXHY7
         cemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=JZkTRoJF263RbRPKioju9++0aJJ/kZntI5sUFtJKOG8=;
        b=jc2MXgaisdxIfJY2xaISAoy4BByiNgkR84V2+ZC2T+gb6Jv4KswHmHf8Ns6VMJR2st
         xMytwDORDHw8A/4Ig2z4Y6/Jf5kXa27e+ejCuqQW5bQbKQlaP3OMviFC+wtvAH2/XGpg
         Dij7PoPAlVbRL/2PLR5uFD3fhuRlT0VF691mwgTIQCq5oreUoVGi1LCBz186B9Rd4eAG
         0eL7k8DWIF6YoaL8ryEp2n3uSkt+Ipcq8Rvpj+9qZtEyevVzgtSH/A+TDGSC5ek22s44
         wHmBMg+oE+tKjio8X0uXTUOPIwaMoTz0OmjKOlSmwnFd47tTX2JYivS/O0YWjyl6I1+h
         pBkg==
X-Gm-Message-State: AG10YOTi5pPBzn7mI6OaBoyNxgg+jDBrROIyp4TF4QWJoktntmoQFmiR9CBPbOap9fO5bm5bG7mwFRAnuw6keg==
X-Received: by 10.31.54.75 with SMTP id d72mr13571489vka.30.1454784279220;
 Sat, 06 Feb 2016 10:44:39 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Sat, 6 Feb 2016 10:44:09 -0800 (PST)
In-Reply-To: <20160205000506.GA6417@flurp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285702>

On Fri, Feb 5, 2016 at 5:35 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Jan 31, 2016 at 11:12:54PM +0530, Karthik Nayak wrote:
>> Introduce remote_ref_atom_parser() which will parse the '%(upstream)'
>> and '%(push)' atoms and store information into the 'used_atom'
>> structure based on the modifiers used along with the corresponding
>> atom.
>>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> @@ -50,6 +52,20 @@ static void color_atom_parser(struct used_atom *atom, const char *color_value)
>> +static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
>> +{
>> +     if (!arg) {
>> +             atom->u.remote_ref = RR_NORMAL;
>> +     } else if (!strcmp(arg, "short"))
>
> Style: drop unnecessary braces
>

Will do.

>> +             atom->u.remote_ref = RR_SHORTEN;
>> +     else if (!strcmp(arg, "track"))
>> +             atom->u.remote_ref = RR_TRACK;
>> +     else if (!strcmp(arg, "trackshort"))
>> +             atom->u.remote_ref = RR_TRACKSHORT;
>> +     else
>> +             die(_("unrecognized format: %%(%s)"), atom->name);
>> +}



-- 
Regards,
Karthik Nayak
