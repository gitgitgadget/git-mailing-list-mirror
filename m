From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [BUG-ish] diff compaction heuristic false positive
Date: Fri, 10 Jun 2016 13:00:53 +0200
Message-ID: <575A9DE5.2020401@alum.mit.edu>
References: <20160610075043.GA13411@sigill.intra.peff.net>
 <575A7AD1.50604@alum.mit.edu> <20160610084149.GA14592@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 10 13:01:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBKBa-0002Va-B1
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 13:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbcFJLBF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 07:01:05 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:46608 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932145AbcFJLBE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2016 07:01:04 -0400
X-AuditID: 12074414-62bff700000008e6-1b-575a9de75fa0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 8C.92.02278.7ED9A575; Fri, 10 Jun 2016 07:00:55 -0400 (EDT)
Received: from [192.168.69.130] (p508EAFFC.dip0.t-ipconnect.de [80.142.175.252])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5AB0rnT003361
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 10 Jun 2016 07:00:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <20160610084149.GA14592@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqPtiblS4wbK3LBZdV7qZLBp6rzBb
	7F7cz2zxo6WH2WLz5nYWB1aPnbPusnss2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZxzd/5G14AVvxcSPMg2Ma7m6GDk5JARMJCbf38TaxcjFISSwlVFi5elTjBDOBSaJu18b
	mUGqhAXsJVpXrWICsUUEZCW+H94IVdTJKLF253kmEIdZoJ9RYv61yawgVWwCuhKLeprBOngF
	tCU2zl/DDmKzCKhKHN+wHaxGVCBE4vy6rawQNYISJ2c+YQGxOQWsJdoWbQWzmQXUJf7Mu8QM
	YctLNG+dzTyBkX8WkpZZSMpmISlbwMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXQi83s0Qv
	NaV0EyMkmEV2MB45KXeIUYCDUYmHN2JXZLgQa2JZcWXuIUZJDiYlUd7Jk6PChfiS8lMqMxKL
	M+KLSnNSiw8xSnAwK4nw9k0HyvGmJFZWpRblw6SkOViUxHm/LVb3ExJITyxJzU5NLUgtgsnK
	cHAoSfAemgPUKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+KyvhiYFyCpHiA9oK1
	8xYXJOYCRSFaTzHqchzZf28tkxBLXn5eqpQ470eQIgGQoozSPLgVsNT1ilEc6GNh3g8gVTzA
	tAc36RXQEiagJcuPhIMsKUlESEk1MLqFxz7he/p0ce65m9blH0JlBM9/Yn0tLLpNUGPr/qbF
	U7SdfFYZ5sqtiTM7O2vOh4U6fhXuit9Y18ZaLGrcNbNi9hZ2Fn+5eWUqFRmPYqy9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296968>

On 06/10/2016 10:41 AM, Jeff King wrote:
> On Fri, Jun 10, 2016 at 10:31:13AM +0200, Michael Haggerty wrote:
>=20
>> I've often thought that indentation would be a good, fairly universa=
l
>> signal for diff to use when deciding how to slide hunks around. Most
>> source code is indented in a way that shows its structure.
>>
>> I propose the following heuristic:
>>
>> * Prefer to start and end hunks following lines with the least
>>   indentation.
>>
>> * Define the "indentation" of a blank line to be the indentation of
>>   the previous non-blank line minus epsilon.
>>
>> * In the case of a tie, prefer to slide the hunk down as far as
>>   possible.
>=20
> Hmm. That might help this case, but the original motivation for this
> heuristic was something like:
>=20
>   ##
>   # foo
>   def foo
>     something
>   end
>=20
>   ##
>   # bar
>   def bar
>     something_else
>   end
>=20
> where we add the first function above the second. We end up with:
>=20
> diff --git a/file.rb b/file.rb
> index 1f9b151..f991c76 100644
> --- a/file.rb
> +++ b/file.rb
> @@ -1,4 +1,10 @@
>  ##
> +# foo
> +def foo
> +  something
> +end
> +
> +##
>  # bar
>  def bar
>    something else
>=20
> I.e., crediting the "##" to the wrong spot (or in C, the "/*"). I don=
't
> think indentation helps us there (sliding-up would, but like
> sliding-down, it just depends on the order of the hunks).
>=20
> So I agree that adding indentation to the mix might help, but I don't
> think it can replace this heuristic.

Ummm, I think the indentation heuristic would work with that example,
too, as long as we consider there to be an imaginary line "0" of the
file (i.e., preceding the first real line) that has an indentation of -=
=CE=B5.

Michael
