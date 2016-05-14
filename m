From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2] diff: run arguments through precompose_argv
Date: Sat, 14 May 2016 07:53:53 +0200
Message-ID: <bcbb1d5e-1f19-e5a9-2b52-d768d118f412@web.de>
References: <1463172062-4175-1-git-send-email-alex@fournova.com>
 <1463172062-4175-2-git-send-email-alex@fournova.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
To: Alexander Rinass <alex@fournova.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 07:54:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1SWi-00010L-R2
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 07:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbcENFx7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 May 2016 01:53:59 -0400
Received: from mout.web.de ([212.227.15.14]:58894 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220AbcENFx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 01:53:58 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0M2ZtN-1brMBj2Ipp-00sP0a; Sat, 14 May 2016 07:53:54
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <1463172062-4175-2-git-send-email-alex@fournova.com>
X-Provags-ID: V03:K0:N4DsxRvtce995qprrxggCJy/SeDQNL6/mPhvQGCSnTCzmIoTasb
 4RiEC+avWyZJVFepdTbtlSHhvj1wWPD+IC0GgsrF/Q58EjhPGGBS88GKrVWWiz2SLTEk78C
 5s3JBws2BnV38+rvc2IoFWWCddtnLukJPRhezzkeBmzPowQAz7iHfnvX+lPudzZjNqUqUO7
 a8fIW+FS2jawcMKzx5Rqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M332Q5+5Xr4=:fF0nwZPIBIphPEX8UFOuM9
 CZNBYu2EccDR+tMA7vG485uwz+Mix1+5TR0KstbWY5725bUnYL9JV9ez+QxXPeeR5K2pKJHPC
 E5IEBxSKPF8sqOVxo0AAeBZqYG92zQ3cH8DaBrB+4BwvvsqLgFnmfg/oqP0dNAY2DIyfOcB+2
 JLcQf+0+UWmGG+F+exd/o3QWJZzhl6jUoUYMiFTZnesHlXqZrn1Jn8HAkhFI4KlVZjr9F1mT/
 pKJ4ZLJU5T5T3+D8e3HWeek4yBcKYRFzLjVFAfrTPmQF02LjgNdoo9F5yRpFf4XegMJaCxE5N
 U5Mv9PR2fWAZyQQjO4294bS+NNZQRxPMmh95Gnjr+Q3NFHd7UGJy1lFDOeMATZ+ACkLAgiRN4
 O8YKFtbDtQGd+0GIZRDlc+Z0of4zxFowmx7gLi7OJOgzAZenOI2fLJOUUEkEkQT6ruZPs0sw4
 B/beQZeAETHnfzsy+2A953myvNdEk18MWIBqzDE+jx+WTvLz8I6PEbMxQMVYICaIbvrd61oBK
 TS9BqoKa2PBlhI4yI692jLcQzGeYq6VvFtl9iP9QrFnurakruign5hVIHK+lG2qUhFRuwbpPF
 Uw8FyF8sdx6l47+PZBQDgScmigemdJJcQCGWXpn62J/v1kzQ/E0qB5Q6w6260wrfhMBUBLQFw
 eVDH3NEq4ewX4cLhhgJETmMpe0i7VJqpvRiYDdy6qXoLtnPGeebSbskX9b18YWoUBoDct90xr
 n0xrSMzrPdSCcHehYM+ZJjDCEIPE0R2AI9BZycmkUwzsTzDtzcfCiQ7ziMJ0/JSxVBb5R6dh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294602>



On 13.05.16 22:41, Alexander Rinass wrote:
> When running diff commands, a pathspec containing decomposed
> unicode code points is not converted to precomposed unicode form
> under Mac OS X, but we normalize the paths in the index and the
> history to precomposed form on that platform.  As a result, the
> pathspec would not match and no diff is shown.
>
> Unlike many builtin commands, the "diff" family of commands do
> not use parse_options(), which is how other builtin commands
> indirectly call precompose_argv() to normalize argv[] into
> precomposed form on Mac OSX.  Teach these commands to call
> precompose_argv() themselves.
>
> Note that precomopose_argv() normalizes not just paths but all
> command line arguments, so things like "git diff -G $string"
> when $string has the decomposed form would first normalized into
> the precomposed form and would stop hitting the same string in
> the decomposed form in the diff output with this change.  It is
> not a problem per-se, as "log" family of commands already use
> parse_options() and call precompose_argv()--we can think of it
> as making the "diff" family of commands behave in a similar way
> as the commands in the "log" family.
>
> Signed-off-by: Alexander Rinass <alex@fournova.com>
> Helped-by: Torsten Bo=CC=88gershausen <tboegi@web.de>
> Helped-by: Junio C Hamano <gitster@pobox.com>
Looks good to me.
