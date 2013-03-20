From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 14/45] Guard against new pathspec magic in pathspec
 matching code
Date: Wed, 20 Mar 2013 15:45:32 -0400
Message-ID: <CAPig+cT37VY7JaMxirQYs7R9V-7E=tur6+Veu+SyLLm-SFj8EQ@mail.gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
	<1363781779-14947-1-git-send-email-pclouds@gmail.com>
	<1363781779-14947-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 20:46:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIOxV-0008Ac-9G
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 20:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757254Ab3CTTpe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Mar 2013 15:45:34 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:35346 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058Ab3CTTpd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Mar 2013 15:45:33 -0400
Received: by mail-la0-f51.google.com with SMTP id fo13so3625864lab.24
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 12:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wrjWYVrkcoOLA+33VHDwBwMd6pmWTOaGkBSTqRovp9I=;
        b=dnVYgba8R3GpXEWeJP2LlDApR0da7vkF4hSTeTzmi4vTvAh/749y4FK/pW3+G7fEAS
         XoSe9KHrWZ5Z8vXlsgslRESe6qUBOn82ZuPlDcFt1xXXaYLyvWn8YtVQ69WnRd386btn
         f8N2f3+456zmTOsRijtiZ3cU1dKzte2TMXGJ6RcmktBIxJHF+GSMUoVz4FWdRZA2Ppbm
         E/ciYVpPO5fDdtWaCcCTI5d6nexjeLDgv/N1QVWDEUsaggWE5LZpN1EwF+PpQdDbZimf
         riclRhA+68MNOFpfhZgGOkp1ibzqJmgsuJ3gg593SOXuUz/WwsdvQEDjC1flUPA770S+
         dpHg==
X-Received: by 10.112.88.35 with SMTP id bd3mr10317152lbb.56.1363808732349;
 Wed, 20 Mar 2013 12:45:32 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Wed, 20 Mar 2013 12:45:32 -0700 (PDT)
In-Reply-To: <1363781779-14947-5-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: r9-HrbsejSNkAM62G-aLFwmZYyw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218665>

On Wed, Mar 20, 2013 at 8:16 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> diff --git a/Documentation/technical/api-setup.txt b/Documentation/te=
chnical/api-setup.txt
> index 59a947e..f62528e 100644
> --- a/Documentation/technical/api-setup.txt
> +++ b/Documentation/technical/api-setup.txt
> @@ -28,3 +28,22 @@ parse_pathspec(). This function takes several argu=
ments:
>  - prefix and args come from cmd_* functions
>
>  get_pathspec() is obsolete and should never be used in new code.
> +
> +parse_pathspec() helps catch unsupported features and reject it

s/reject it/reject them/

> +politely. At a lower level, different pathspec-related functions may
> +not support the same set of features. Such pathspec-sensitive
> +functions are guarded with GUARD_PATHSPEC(), which will die in an
> +unfriendly way when an unsupported feature is requested.
