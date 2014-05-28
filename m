From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH 2/2] config: Add new query functions to the api
Date: Wed, 28 May 2014 05:43:06 -0400
Message-ID: <CAPig+cQZMNSZ-3C0zR3mvxp0n7C_L79wQex5L85Xr_w+8yvBZA@mail.gmail.com>
References: <1401125601-18249-1-git-send-email-tanayabh@gmail.com>
	<1401125601-18249-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 11:43:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpaOQ-0007ZO-Rb
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 11:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbaE1JnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 05:43:09 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:50555 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbaE1JnH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 05:43:07 -0400
Received: by mail-yk0-f178.google.com with SMTP id 20so8068966yks.23
        for <git@vger.kernel.org>; Wed, 28 May 2014 02:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=v9Wd+ElsW+BRhSLru/hi0vaxcZJR/tB2j4oZc6dqLAk=;
        b=wE09imTF0YR54RqPG4jfLBYMOTnlnpJF9EUbf0SraxVolubkPF8eqgseKLTFJauBKM
         IleKmOtZyJU9eD00jjR83uWn0JmT+HjNylb9DpfSM8cTrjgRNTOlW3ltiYrvH/wmACU3
         4WVKGXg3K46Ap7j715NSAYVgB3dm0vkzN/F68UuQe8OEqoYmyWQVJgcpOh41C8EVXzsp
         Liji8dA60bp5L3b86K28Wra4k4Npcpa8iCze3FGFojjjIILT6HgYQJPRHUDmNqBeBZdp
         +krXjXcDQn9tcF+GQTPE/7oszuFU2JcY5jWhqQbj9JfZgE5sfNwwprwgEjfzEIkz40gk
         Jx6g==
X-Received: by 10.236.30.105 with SMTP id j69mr55017362yha.19.1401270186314;
 Wed, 28 May 2014 02:43:06 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Wed, 28 May 2014 02:43:06 -0700 (PDT)
In-Reply-To: <1401125601-18249-3-git-send-email-tanayabh@gmail.com>
X-Google-Sender-Auth: 5rw-5AkTGvCx4RagsddD_2a0oUA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250278>

On Mon, May 26, 2014 at 1:33 PM, Tanay Abhra <tanayabh@gmail.com> wrote:
> Subject: config: Add new query functions to the api

This sounds as if you are adding new functions to the header file.
Saying "... to the api docs" would been clearer. Better:

    config: document new query functions

> Add explanations for `git_config_get_string_multi` and `git_config_get_string`
> which utilize the config cache for querying in an non callback manner for a

s/an/a/
s/non/non-/

> specific variable.
>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>

One might expect these functions to be documented in the same patch
which introduces them. Since this patch is so small, it might make
sense just to squash it into patch 1.

More below.

> ---
>  Documentation/technical/api-config.txt | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
> index 230b3a0..33b5b90 100644
> --- a/Documentation/technical/api-config.txt
> +++ b/Documentation/technical/api-config.txt
> @@ -77,6 +77,25 @@ To read a specific file in git-config format, use
>  `git_config_from_file`. This takes the same callback and data parameters
>  as `git_config`.
>
> +Querying for specific variables
> +-------------------------------

All other section headers in this file capitalize each word.

> +For programs wanting to query for specific variables in a non callback

s/non-/

> +manner, the config API provides two functions `git_config_get_string`
> +and `git_config_get_string_multi`. They both take a single parameter,
> +
> +- a variable as the key string for which the corresponding values will
> +  be retrieved and returned.
> +
> +They both read value from an internal cache generated previously from

Minor observation: As this file is documenting the API, mentioning
private implementation details such, as the "internal cache", may be
frowned upon (though probably doesn't matter in practice since this
_is_ a technical document).

> +reading the config files. `git_config_get_string` returns the value with
> +the highest priority(i.e. value in the repo config will be preferred over
> +value in user wide config for the same variable).
> +
> +`git_config_get_string_multi` returns a `string_list` containing all the
> +values for that particular variable, sorted in order of increasing
> +priority.
> +
>  Value Parsing Helpers
>  ---------------------
>
> --
> 1.9.0.GIT
