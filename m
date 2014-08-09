From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Add failing test: "fsck survives inflate errors"
Date: Sat, 9 Aug 2014 13:53:12 +0700
Message-ID: <CACsJy8B-sKKVSDZUMGLmnGUsgHZ9iQMNG-Vum4SCL1rr5Yk5Rw@mail.gmail.com>
References: <1405831383-22477-1-git-send-email-naesten@gmail.com> <87mwc37od7.fsf@naesten.mooo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Samuel Bronson <naesten@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 08:53:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XG0XD-00062f-M0
	for gcvg-git-2@plane.gmane.org; Sat, 09 Aug 2014 08:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbaHIGxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2014 02:53:43 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38936 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbaHIGxm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2014 02:53:42 -0400
Received: by mail-ig0-f181.google.com with SMTP id h3so2071051igd.14
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 23:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ps1/HvDYR1NsdFO9ZaPK7hchqCVJ49uBeUp5ZlZmhW4=;
        b=Cy/xzvF6l4XSbDOdYztFohVsZrL8DgIyKdkGIrca1ZpURrPGkQYYyt7EdR+1LX02ys
         GkDgU9ANP6moRzyokVk9/7pN4U+9SykUJSgTdYl0616bbDIWJkPqaYoN/6hSidee/ZK6
         1IMcnOMfCnMBnc8meBXw2oCX7Ut/ggXDV2qrEJ4FwSgK6p1dexl2U9UXCYl8eqblBoFF
         IL8tg3du4V18Kl4dTc2cNFzb16h59Fidpm1CJDVcB5RloFDtqTshheMPsDE/ECRO2kU3
         gE4EH39Wqk2JWaNfLxX1XPMIhjotUeII6SKlRsBi8ldkjefZq8FLHVcyZ78pexE/TUDj
         ry8w==
X-Received: by 10.51.17.66 with SMTP id gc2mr11686566igd.40.1407567222172;
 Fri, 08 Aug 2014 23:53:42 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Fri, 8 Aug 2014 23:53:12 -0700 (PDT)
In-Reply-To: <87mwc37od7.fsf@naesten.mooo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255073>

On Mon, Jul 21, 2014 at 3:43 AM, Samuel Bronson <naesten@gmail.com> wrote:
> So, given that parse_object()'s documentation is:
>
> --8<---------------cut here---------------start------------->8---
> /*
>  * Returns the object, having parsed it to find out what it is.
>  *
>  * Returns NULL if the object is missing or corrupt.
>  */
> --8<---------------cut here---------------end--------------->8---
>
> it probably should not call read_sha1_file() on a corrupt object.
>
> Options for fixing this would appear to include:
>
> 1. Saving the result of sha1_object_info(sha1, NULL) to a variable and
>    returning early if the object is corrupt.  (But what happens if there
>    is corruption far enough in that it isn't seen when trying to grab
>    the object header?)
>
> 2. Calling read_object() and giving our own error messages.
>
> 3. Making read_sha1_file_extended only *optionally* die; since it's
>    calling die() directly.

We've been using die() quite freely (or at least used to) and there
are many more cases that can trigger die() and parse_object() can do
nothing about it. Adding a "gentle" flag to read_sha1_file_extended
and pass it further down could be the first step. Patches welcome.
-- 
Duy
