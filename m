Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C742C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 01:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A3522527
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 01:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4c/8944"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfLMBoh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 20:44:37 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39372 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfLMBoh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 20:44:37 -0500
Received: by mail-pl1-f194.google.com with SMTP id o9so524685plk.6
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 17:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yzj5lTbEDqyGpqQUi6WheMacKoVWKe+cgtz1LqYMDHc=;
        b=c4c/8944pmai0R7GB639LjDodFci8zzLXvWCrpVFEz3W5tIRIKyONpDwBtYXqNgJeN
         sOodFPhhYW5Or6wfsHhZg12iEvfLFfraBuac+YCk7GCIAUvV0biPkyeBAqNtUvHtyVIN
         mhmx9a5u03HkuDUJIL/xG44x9FkW7KQTyTC6BJ/mkB7UNjtDGJAN7MXQ4k+tZCxyrg2D
         7uRNZG7fPX7xZI6CBicW3nk4H5ItPxz31YligHsJXQ2vYUly/sSSdAo4pOS2r1M9WNQD
         lIktNREa9okvv8XSse89evyNQmzY3KO8wvKFMUgLH8yinSYY1LqPl07g1fEuV2tfv9bU
         vEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yzj5lTbEDqyGpqQUi6WheMacKoVWKe+cgtz1LqYMDHc=;
        b=ITVbqCsKc3iTr6DV60m9jqgyXJXyUAxyfkrZnKPY15ow3pjDmg5Luz/oK36aWAHq+d
         UjNO+auCqC5WJd3jR5lXsYELSmQW5svjWC9w+SVSp+t42wevNWeSw5dxvxDz8yMMuw/4
         EcPAiSb/Zpru1diPgA32Oe0/+ZWL+pOpT47seQmkLM5ZffH+gG8QyEV7N2Hv+/dsX4Og
         s0fJyMisCg8i4v67aTgVFK6nQ7kvIyJM+NyTAAT62/UdQ1WZAKW18bWuJVh03f/nrXZj
         qZLfztSToADuVTBiOFbwFzJyWwtrAUfzAKQETnWam/ZpZCq6P/pZVbU/oKJiZnVTQx9H
         wC3A==
X-Gm-Message-State: APjAAAUS4VuB/9L325jpvlm8a+38dw6BMPFJAvCu0AbiSeaQurek3Bdz
        pUvhz+nT/6SZJ7uHjWD8VJg=
X-Google-Smtp-Source: APXvYqxLg6aZBJ0Kh3xO9zlMhK2bNIPdq3WJPBeUOgHNPIMUdn1EG4fMoKoac1Z82vbtBv/o6Zq5uA==
X-Received: by 2002:a17:902:8a8a:: with SMTP id p10mr13100312plo.300.1576201476206;
        Thu, 12 Dec 2019 17:44:36 -0800 (PST)
Received: from generichostname ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id n188sm8193644pga.84.2019.12.12.17.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 17:44:35 -0800 (PST)
Date:   Thu, 12 Dec 2019 17:45:37 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] git-p4: yes/no prompts should sanitize user text
Message-ID: <20191213014537.GA13064@generichostname>
References: <pull.675.v2.git.git.1575991374.gitgitgadget@gmail.com>
 <pull.675.v3.git.git.1576179987.gitgitgadget@gmail.com>
 <fff93acf4430e2e7702ae1345f9899244a9867aa.1576179987.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fff93acf4430e2e7702ae1345f9899244a9867aa.1576179987.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

On Thu, Dec 12, 2019 at 07:46:24PM +0000, Ben Keene via GitGitGadget wrote:
> From: Ben Keene <seraphire@gmail.com>
> 
> When prompting the user interactively for direction, the tests are
> not forgiving of user input format.
> 
> For example, the first query asks for a yes/no response. If the user
> enters the full word "yes" or "no" or enters a capital "Y" the test
> will fail.
> 
> Create a new function, prompt(prompt_text) where
>   * promt_text is the text prompt for the user

s/promt/prompt/

>   * choices are extracted from the prompt text [.]
>       a single letter surrounded by square brackets
>       is selected as a valid choice.

Maybe something like this?

	* returns a single character where valid return values are
	  found by inspecting prompt_text for single characters
	  surrounded by square brackets
> 
> This new function must  prompt the user for input and sanitize it by
> converting the response to a lower case string, trimming leading and
> trailing spaces, and checking if the first character is in the list
> of choices. If it is, return the first letter.
> 
> Change the current references to raw_input() to use this new function.
> 
> Since the method requires the returned text to be one of the available
> choices, remove the loop from the calling code that handles response
> verification.
> 
> Signed-off-by: Ben Keene <seraphire@gmail.com>
> ---
>  git-p4.py | 68 ++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 37 insertions(+), 31 deletions(-)
> 
> diff --git a/git-p4.py b/git-p4.py
> index 60c73b6a37..a05385ee2a 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -167,6 +167,21 @@ def die(msg):
>          sys.stderr.write(msg + "\n")
>          sys.exit(1)
>  
> +def prompt(prompt_text):
> +    """ Prompt the user to choose one of the choices
> +
> +    Choices are identified in the prompt_text by square brackets around
> +    a single letter option.
> +    """
> +    choices = set(m.group(1) for m in re.finditer(r"\[(.)\]", prompt_text))

Nice ;)

> +    while True:
> +        response = raw_input(prompt_text).strip().lower()
> +        if not response:
> +            continue
> +        response = response[0]
> +        if response in choices:
> +            return response
> +
>  def write_pipe(c, stdin):
>      if verbose:
>          sys.stderr.write('Writing pipe: %s\n' % str(c))
> @@ -1778,12 +1793,11 @@ def edit_template(self, template_file):
>          if os.stat(template_file).st_mtime > mtime:
>              return True
>  
> -        while True:
> -            response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
> -            if response == 'y':
> -                return True
> -            if response == 'n':
> -                return False
> +        response = prompt("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
> +        if response == 'y':
> +            return True
> +        if response == 'n':
> +            return False
>  
>      def get_diff_description(self, editedFiles, filesToAdd, symlinks):
>          # diff
> @@ -2345,31 +2359,22 @@ def run(self, args):
>                            " --prepare-p4-only")
>                      break
>                  if i < last:
> -                    quit = False
> -                    while True:
> -                        # prompt for what to do, or use the option/variable
> -                        if self.conflict_behavior == "ask":
> -                            print("What do you want to do?")
> -                            response = raw_input("[s]kip this commit but apply"
> -                                                 " the rest, or [q]uit? ")
> -                            if not response:
> -                                continue
> -                        elif self.conflict_behavior == "skip":
> -                            response = "s"
> -                        elif self.conflict_behavior == "quit":
> -                            response = "q"
> -                        else:
> -                            die("Unknown conflict_behavior '%s'" %
> -                                self.conflict_behavior)
> -
> -                        if response[0] == "s":
> -                            print("Skipping this commit, but applying the rest")
> -                            break
> -                        if response[0] == "q":
> -                            print("Quitting")
> -                            quit = True
> -                            break
> -                    if quit:
> +                    # prompt for what to do, or use the option/variable
> +                    if self.conflict_behavior == "ask":
> +                        print("What do you want to do?")
> +                        response = prompt("[s]kip this commit but apply the rest, or [q]uit? ")
> +                    elif self.conflict_behavior == "skip":
> +                        response = "s"
> +                    elif self.conflict_behavior == "quit":
> +                        response = "q"
> +                    else:
> +                        die("Unknown conflict_behavior '%s'" %
> +                            self.conflict_behavior)
> +
> +                    if response == "s":
> +                        print("Skipping this commit, but applying the rest")
> +                    if response == "q":
> +                        print("Quitting")
>                          break
>  
>          chdir(self.oldWorkingDirectory)

Aside from the one comment at the bottom, I reviewed the rest of this
patch with `-w` and it looks good to me. Unfortunately, I don't use or
know p4 so I haven't tested it.

> @@ -4170,3 +4175,4 @@ def main():
>  
>  if __name__ == '__main__':
>      main()
> +

Spurious trailing line. Perhaps we could make GGG error out on
whitespace errors before submissions are allowed?

> -- 
> gitgitgadget
> 
