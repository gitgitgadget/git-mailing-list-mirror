From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] test-bzr: Do not use unportable sed "\+"
Date: Sat, 11 May 2013 22:00:17 +0200
Message-ID: <518EA351.8000603@web.de>
References: <201305111525.53130.tboegi@web.de> <7vwqr5wdqm.fsf@alter.siamese.dyndns.org> <7vobchwbax.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	felipe.contreras@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 11 22:00:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbFyE-0004kW-VF
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 22:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989Ab3EKUA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 16:00:28 -0400
Received: from mout.web.de ([212.227.17.11]:59436 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753879Ab3EKUA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 16:00:27 -0400
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0Lz3CK-1UWlsJ1zX6-014cPl; Sat, 11 May 2013 22:00:19 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7vobchwbax.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:nJjeI1Ixmr6etbTVAXA5Fl6AKWXhkIKwKnzNVr8rZTs
 7GQqHCMFWZmPyjJWRpZcg14bkgHBSafjgitu3neAH8YO4uraH1
 9a6jPy+l3nqOfcg/UbN+MMW4qiQ8fYL7NYk33coE2uLStb6mfZ
 pkRyOubmx/sqUmKeI6gM8uOgfkfWBZXjiOWTE0mfcsZQfU9/w0
 qWx7r+wmsvIio5zP0qqoA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224007>

On 11.05.13 21:45, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Thanks.  Is there another one in t/t5551-http-fetch.sh that checks
>> the tags?
> 
> I think your sed will see the same breakage for the one in 5551 (my
> sed is unfortunately GNU and ".\+" does not break it).  Could you
> test this patch with:
> 
>      GIT_TEST_LONG=YesPlease GIT_TEST_HTTPD=YesPlease \
>      ./t5551-http-fetch.sh
> 
> Thanks.
> 
>  t/t5551-http-fetch.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
> index b23efbb..4a3184e 100755
> --- a/t/t5551-http-fetch.sh
> +++ b/t/t5551-http-fetch.sh
> @@ -209,7 +209,7 @@ test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
>  
>  	# now assign tags to all the dangling commits we created above
>  	tag=$("$PERL_PATH" -e "print \"bla\" x 30") &&
> -	sed -e "s/^:\(.\+\) \(.\+\)$/\2 refs\/tags\/$tag-\1/" <marks >>packed-refs
> +	sed -e "s|^:\([^ ]*\) \(.*\)$|\2 refs/tags/$tag-\1|" <marks >>packed-refs
>  	)

I did,
the interesting thing is that the test passes with and without your patch.
(After enabling  GIT_TEST_LONG and GIT_TEST_HTTPD in both cases)


Side note:
I added this line in in t/check-non-portable-shell.pl
  /sed[^"]+"[^"]+\\([+])/ and err "sed \\$1 is not portable)";
