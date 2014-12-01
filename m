From: David Michael <fedora.dm0@gmail.com>
Subject: Re: [PATCH] compat: convert modes to use portable file type values
Date: Mon, 1 Dec 2014 12:49:59 -0500
Message-ID: <CAEvUa7mhjG1xPoJedp4XYrxr39_EuzvGtONLv0B=uBw+vQB5pw@mail.gmail.com>
References: <87vblxl8ah.fsf@gmail.com>
	<CACsJy8CKEwOVcB_MUaK8mmSmQuKHC6R6K0YymjCrTP3aYFdbPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 18:50:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvV6t-0000tn-KI
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 18:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406AbaLARuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 12:50:01 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:55653 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbaLARuA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 12:50:00 -0500
Received: by mail-pa0-f50.google.com with SMTP id bj1so11623392pad.9
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 09:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rrdIK7XrxP7HVhlU6sZohWygfhyp9VoSsUjIcmWH21M=;
        b=aFQuAOeV/Gx04BxkOGrBcQDXCJrcIbex0+Lc+0//uJunaQJoj5ZjsGei1s1WuWEtvZ
         l4k/e6OiAtwIR06cyQ/xkq8b4bSJtt1vKRgLBZaAzRWln4DWK9GE+Z9xypQ6IoT4IuOr
         KP2kb61sUOP+r2ZKrWHTSQpe9X0OeT3cwgx3rH4pbW5uVIO4KRsT6xySpyjaZcDk0g8v
         MjuvZyjlAgKKuMDHOaZkC9ICFqKCA19QxbQfrnrEIfJimKqCV0CAtunIJrISRyeNplIs
         1o7921cyk/q4HrkmVQG2LCEI4c21/uYbekpOlCYGx9LDjFHPjt9b5AQLG7lBjNDtjMSE
         rXZg==
X-Received: by 10.66.241.239 with SMTP id wl15mr48679727pac.15.1417456200037;
 Mon, 01 Dec 2014 09:50:00 -0800 (PST)
Received: by 10.70.55.36 with HTTP; Mon, 1 Dec 2014 09:49:59 -0800 (PST)
In-Reply-To: <CACsJy8CKEwOVcB_MUaK8mmSmQuKHC6R6K0YymjCrTP3aYFdbPg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260498>

On Mon, Dec 1, 2014 at 9:44 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Nov 30, 2014 at 9:41 AM, David Michael <fedora.dm0@gmail.com> wrote:
>> +int git_stat(const char *path, struct stat *buf)
>> +{
>> +       int rc;
>> +       rc = stat(path, buf);
>> +       if (buf != NULL)
>
> It's a minor thing, but maybe test "!rc" instead of "buf != NULL"?

Okay, it makes sense to only do the conversion for a successful return code.

Should it test for both a zero return code and a non-null pointer?  I
don't know if there are any cases where passing a null pointer is
legal.  The standard doesn't seem to explicitly forbid it.  z/OS
returns -1 and sets errno to EFAULT when stat() is given NULL, but
this patch should be able to be used on any platform.

David
