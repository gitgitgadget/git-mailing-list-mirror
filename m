From: Yuxuan Shui <yshuiv7@gmail.com>
Subject: Re: [PATCH v2 1/2] fsck.c: Change the type of fsck_ident()'s first argument
Date: Thu, 13 Mar 2014 12:29:20 +0800
Message-ID: <CAGqt0zwivxtsKqZz9mGPxECHXt3Xd8eJLhDdBPr7Kpk-+UT5uQ@mail.gmail.com>
References: <1394650290-3750-1-git-send-email-yshuiv7@gmail.com>
	<1394650290-3750-2-git-send-email-yshuiv7@gmail.com>
	<20140312202251.GA3642@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 05:29:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNxH9-0000dW-MG
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 05:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbaCME3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 00:29:21 -0400
Received: from mail-vc0-f179.google.com ([209.85.220.179]:53042 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbaCME3U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 00:29:20 -0400
Received: by mail-vc0-f179.google.com with SMTP id ij19so504728vcb.24
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 21:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7HR8oBAbeck19oY3OQpm/D87vycfkReDnpGp2MwCdLA=;
        b=ZI8lzhmDuhLQzIYYO2eQsQZJOeYLYxH7aNY3PQLJfzPbzvMh3lj6M4OCA1Gn36FKy3
         RLhQQyQQBU3ztJDGk6d9hfXUd0Un9BoM892PYg6xfCpXC0JzbIKM231jCuw/QWvCh7go
         Abv2yR0gsESDTe+nmCkdgtDoX4Ve8q7qD8E7rN7vs2xAEaqhL4+VMJ2zX8/lcqbztfXH
         vEqX2DwPYvUkyiTbEzOJVN/Ej+B7kbgodJVWh/Y6K2cVA55uTIfwKYeLR++PEFqoRw8A
         vnLiHeYWxJBDIedariVqaWK78yo8xAnZj0Py9jHzQB3E7twLiV+3WtJDTwLX4BDKxm8b
         cErA==
X-Received: by 10.58.34.241 with SMTP id c17mr35937vej.74.1394684960221; Wed,
 12 Mar 2014 21:29:20 -0700 (PDT)
Received: by 10.220.89.209 with HTTP; Wed, 12 Mar 2014 21:29:20 -0700 (PDT)
In-Reply-To: <20140312202251.GA3642@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244018>

Hi,

On Thu, Mar 13, 2014 at 4:22 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 13, 2014 at 02:51:29AM +0800, Yuxuan Shui wrote:
>
>> Since fsck_ident doesn't change the content of **ident, the type of
>> ident could be const char **.
>
> Unfortunately, const double-pointers in C are a bit tricky, and a
> pointer to "char *" cannot automatically be passed as a pointer to
> "const char *".

Thanks for pointing this out, I split the changes in a wrong way. I'll
fix this in next version of this patch.

>
> I think you want this on top:
>
> diff --git a/fsck.c b/fsck.c
> index 1789c34..7776660 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -281,7 +281,7 @@ static int fsck_ident(const char **ident, struct object *obj, fsck_error error_f
>
>  static int fsck_commit(struct commit *commit, fsck_error error_func)
>  {
> -       char *buffer = commit->buffer;
> +       const char *buffer = commit->buffer;
>         unsigned char tree_sha1[20], sha1[20];
>         struct commit_graft *graft;
>         int parents = 0;
>
> Otherwise, gcc will complain about incompatible pointer types.
>
> -Peff

-- 

Regards
Yuxuan Shui
