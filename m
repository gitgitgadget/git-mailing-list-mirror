From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git-p4: add config git-p4.pathEncoding
Date: Wed, 02 Sep 2015 09:30:44 -0700
Message-ID: <xmqqtwrcokaz.fsf@gitster.mtv.corp.google.com>
References: <1441205853-52065-1-git-send-email-larsxschneider@gmail.com>
	<1441205853-52065-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org, tboegi@web.de
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Wed Sep 02 18:30:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXAw0-00027x-Db
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 18:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200AbbIBQas convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Sep 2015 12:30:48 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36351 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753280AbbIBQaq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 12:30:46 -0400
Received: by pacwi10 with SMTP id wi10so16568384pac.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 09:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=n8p+mwXG70hMZ2fhMFjzom8WEhb2mE9ecg3o4KxcnzM=;
        b=cjycOR6O0TTge4Ng9bhadL44E8RbL9GHneY4G1Jb2bxpi52+jjGLTUGwSW/uWGiXLs
         tkcBfyw2LgZ7WSVETlJNFbl42+t7FKHwb2YZbvKLO9eO2gMplS5EZSIWDCrw4ykn/EcV
         DIJqcePJ+XJiDwJMlUhO4TOh9VoDhkQGHeX1G/n7usLbIbQwMkyfMXUwVV2hw56d1Kes
         P7iDHeC7shGbJcU2jVTGwT27vBU0rllcwU06q+DOzzCyUm3pe/pNIXyLXpxz9pH5U1qN
         Gz1eTYRgBUQBYO9H7F+yXhgRPcQyppg7FJv0L1BWvxMToLjBaMcBI8k/LqfyZsvrEH5y
         gIVg==
X-Received: by 10.68.104.98 with SMTP id gd2mr5201193pbb.130.1441211446550;
        Wed, 02 Sep 2015 09:30:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2414:9e5f:bc96:1638])
        by smtp.gmail.com with ESMTPSA id ip7sm22157165pbc.68.2015.09.02.09.30.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 02 Sep 2015 09:30:45 -0700 (PDT)
In-Reply-To: <1441205853-52065-2-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Wed, 2 Sep 2015 16:57:33
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277106>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> Perforce keeps the encoding of a path as given by the originating OS.
> Git expects paths encoded as UTF-8. Add a config to tell git-p4 what
> encoding Perforce had used for the paths. This encoding is used to
> transcode the paths to UTF-8. As an example, Perforce on my Windows
> box uses =E2=80=9Ccp1252=E2=80=9D to encode path names.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---

Thanks.

> +git-p4.pathEncoding::
> +	Perforce keeps the encoding of a path as given by the originating O=
S.
> +	Git expects paths encoded as UTF-8. Use this config to tell git-p4=20
> +	what encoding Perforce had used for the paths. This encoding is use=
d
> +	to transcode the paths to UTF-8. As an example, Perforce on my Wind=
ows
> +	box uses =E2=80=9Ccp1252=E2=80=9D to encode path names.
> +

The log message is sort of personal statement, but "my Windows"
smells out of place here, as there is no clear writer in the
documentation.  Perhaps rephrase it to:

    For example, Perforce often uses "cp1252" to encode path names
    on Windows box.

or something?

> diff --git a/t/t9822-git-p4-path-encoding.sh b/t/t9822-git-p4-path-en=
coding.sh
> new file mode 100755
> index 0000000..3a1779a
> --- /dev/null
> +++ b/t/t9822-git-p4-path-encoding.sh
> @@ -0,0 +1,65 @@
> +#!/bin/sh
> +
> +test_description=3D'Clone repositories with non ASCII paths'
> +
> +. ./lib-git-p4.sh
> +
> +UTF8_ESCAPED=3D"a-\303\244_o-\303\266_u-\303\274.txt"
> +ISO8859_ESCAPED=3D"\141\55\344\137\157\55\366\137\165\55\374\56\164\=
170\164"
> +
> +# You can generate the ISO8859_ESCAPED with the following command:

Please don't.  You don't want to encode ".txt" and other things that
are ASCII, which you didn't encode in the original UTF8_ESCAPED.

> +# printf "$UTF8_ESCAPED" | \
> +# iconv -f utf-8 -t iso8859-1 | \
> +# xxd -ps -u -c 1 | xargs bash -c 'for v; do echo "ibase=3D16; obase=
=3D8; $v" | bc; done' bash | \
> +# tr "\n" "\\"

Besides, you somehow came up with UTF8_ESCAPED with a procedure that
is not documented (and it does avoid hiding obvious things like
".txt" in the backslashes).  I do not think it is necessary or even
a good idea to give a procedure that is not very portable (xxd?
bash?) and does not produce what we want to see, only for ISO8859.
