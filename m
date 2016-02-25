From: Olga Pshenichnikova <olga@ip-5.ru>
Subject: Re: Some strange behavior of git
Date: Thu, 25 Feb 2016 19:43:08 +0300
Message-ID: <56CF2F1C.9070803@ip-5.ru>
References: <56CE31F8.7090706@ip-5.ru> <20160225095755.GJ1831@hank>
 <56CED1F8.60601@ip-5.ru> <20160225161409.GK1831@hank>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 17:43:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYz0X-00071o-3T
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 17:43:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759879AbcBYQnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 11:43:12 -0500
Received: from [178.62.228.239] ([178.62.228.239]:56972 "EHLO server.ip-5.ru"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752104AbcBYQnM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 11:43:12 -0500
Received: from [10.143.42.152] (unknown [31.40.132.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by server.ip-5.ru (Postfix) with ESMTPSA id D5A46100F5D;
	Thu, 25 Feb 2016 19:43:08 +0300 (MSK)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <20160225161409.GK1831@hank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287399>

Thanx )

On 02/25/2016 07:14 PM, Thomas Gummerer wrote:
> [Please keep everyone cc'd in the conversation, especially the mailing
> list.  I added it back for now.
> Also please don't top post on the list]
>
> On 02/25, Olga Pshenichnikova wrote:
>> No, it isn't empty, but I found the problem.
>> Problem was that I handled subdirectories structure in exclude file:
>>
>> design/dir1
>> design/dir2
>>
>> But
>>
>> design/dir3 wasn't ignored and wasn't controlled.
>>
>> So, my problem take place when some sub directory both isn't ignored AND
>> isn't controlled even if it isn't empty.
> I think that's a bug, I think this directory should only be removed if
> -x is given.  I haven't come up with a patch yet, but here's a test
> demonstrating the failure.
>
> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> index 86ceb38..0961007 100755
> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -653,4 +653,13 @@ test_expect_success 'git clean -d respects pathspecs (pathspec is prefix of dir)
>   	test_path_is_dir foobar
>   '
>
> +test_expect_failure 'git clean -d does not clean ignored files in subdir' '
> +	mkdir -p sub/dir &&
> +	>sub/dir/file &&
> +	test_when_finished rm .gitignore &&
> +	echo sub/dir/ >.gitignore &&
> +	git clean -df sub &&
> +	test_path_is_file sub/dir/file
> +'
> +
>   test_done
>
>
>> Thank you for response!
