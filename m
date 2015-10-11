From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/3] Add Travis CI support
Date: Sun, 11 Oct 2015 16:40:59 -0400
Message-ID: <CAPig+cQ4Gd6aNQdrdD7ZEJW2Mn=pJujkqje0-htJpJYz8LVbhQ@mail.gmail.com>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com>
	<1444586102-82557-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Pete Wyckoff <pw@padd.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 22:41:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlNQY-0006pQ-3C
	for gcvg-git-2@plane.gmane.org; Sun, 11 Oct 2015 22:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbbJKUlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2015 16:41:00 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:36651 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbbJKUlA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2015 16:41:00 -0400
Received: by vkgc187 with SMTP id c187so13364150vkg.3
        for <git@vger.kernel.org>; Sun, 11 Oct 2015 13:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=a9PEXgZ3BVYm5r+0gjt/1qCU6PHYI5NQWWH1lItcn6Q=;
        b=adQuXU1aeCELtQC3Q6IyBAesG9g6YT+CENnfMKRr3cBOpS18QCx+yusbwd1tU5Zooa
         GrC8YYifZYdu5vmpSMPFsyML17rzuIfmF2d6+YFwzR+WHvzC23LwzN/WLd3/ZiGtHID8
         nl41Iif34lYdG9jjD/VD1cjkU6JhZ8MK0QNkpYIFSZP8IEPUb1rrGE//cGgxrjA74dLO
         IE27Qro+dq9otNz5xxogMAM1ntYCX6kWozx7xQEGsMTHAJdMCkfXYCE77BcW09tnQQ5J
         8WJPmFlmoKiBXIdoBraHuMhF0nO+BOZAR85/hwsMBVtfIcZlNIoU3MsudSvx/ru5prC6
         VT7A==
X-Received: by 10.31.56.193 with SMTP id f184mr16360049vka.115.1444596059397;
 Sun, 11 Oct 2015 13:40:59 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Sun, 11 Oct 2015 13:40:59 -0700 (PDT)
In-Reply-To: <1444586102-82557-2-git-send-email-larsxschneider@gmail.com>
X-Google-Sender-Auth: GyZEJyc9Llp515yQuXJNqwikses
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279358>

On Sun, Oct 11, 2015 at 1:55 PM,  <larsxschneider@gmail.com> wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> The tests are currently executed on "Ubuntu 12.04 LTS Server Edition
> 64 bit" and on "OS X Mavericks" using gcc and clang.
>
> Perforce and Git-LFS are installed and therefore available for the
> respective tests.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> diff --git a/.travis.yml b/.travis.yml
> new file mode 100644
> index 0000000..25a7079
> --- /dev/null
> +++ b/.travis.yml
> @@ -0,0 +1,46 @@
> +language: c
> +
> +os:
> +  - linux
> +  - osx
> +
> +compiler:
> +  - clang
> +  - gcc
> +
> +before_install:
> +  - >
> +    export GIT_TEST_OPTS=" --quiet";
> +    case "${TRAVIS_OS_NAME:-linux}" in
> +    linux)
> +      wget -q https://package.perforce.com/perforce.pubkey -O - \
> +        | sudo apt-key add -
> +      echo 'deb http://package.perforce.com/apt/ubuntu precise release' \
> +        | sudo tee -a /etc/apt/sources.list
> +      wget -q https://packagecloud.io/gpg.key -O - | sudo apt-key add -
> +      echo 'deb https://packagecloud.io/github/git-lfs/debian/ jessie main' \
> +        | sudo tee -a /etc/apt/sources.list
> +      sudo apt-get update -qq
> +      sudo apt-get install -y apt-transport-https
> +      sudo apt-get install perforce-server git-lfs
> +      ;;
> +    osx)
> +      brew_force_set_latest_binary_hash () {
> +        FORUMULA=$1

Is this spelling intentional or is it a misspelling of "formula"?

> +        SHA=$(brew fetch --force $FORUMULA 2>&1 | grep ^SHA256: | cut -d ' ' -f 2)
> +        sed -E -i.bak "s/sha256 \"[0-9a-f]{64}\"/sha256 \"$SHA\"/g" \
> +          /usr/local/Library/Taps/homebrew/homebrew-binary/$FORUMULA.rb
> +      }
> +      brew update
> +      brew tap homebrew/binary
> +      brew_force_set_latest_binary_hash perforce
> +      brew_force_set_latest_binary_hash perforce-server
> +      brew install git-lfs perforce-server perforce
> +      ;;
> +    esac
> +
> +install: make configure && ./configure
> +
> +before_script: make
> +
> +script: make --quiet test
> --
> 2.5.1
