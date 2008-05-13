From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Paginate project list
Date: Tue, 13 May 2008 08:55:07 +0200
Message-ID: <200805130855.08133.jnareb@gmail.com>
References: <200805011220.58871.jnareb@gmail.com> <200805120903.25040.jnareb@gmail.com> <8c5c35580805120843j9b401f8mfa104806880a51c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"J.H." <warthog19@eaglescrag.net>
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 08:56:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvoQv-0006MX-Id
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 08:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbYEMGzN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2008 02:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751957AbYEMGzN
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 02:55:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:62154 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbYEMGzL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 02:55:11 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1188904nfc.21
        for <git@vger.kernel.org>; Mon, 12 May 2008 23:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=lMT+XJfkwzNel+UgtNT9PhsNB5SWfWMiu6F+ev8J8gw=;
        b=SRBbygrKmh+hcXVXieoIid2S8qKu1qwpCjNUN75bDJ8B5KGJkLjFReMYuzHnOlCGVR7dd7aZ0FtwVhGSXyXupfyVIm6BW2uV3H4U24Lz5ms3kRlqP+n2GnvkdRm5uIE1giJ7l9ydGWvmHsrfULMVWnNFn0KLas37kmbfCEWlFb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=R7zSGN5vgr5cdRzjVW1CL7d+e+TRGW6lpJJYnMzBHxEzNwMPkFiZAqJgD67QPcs46W+AXI3/UIgwT2c1YC7tdY74w6z8modh4NPQ7rL40QwJDsNX2Tt19jUeRualrJ8GCP4vykb4OUHJEET4qZr3gPxXPA/wN9pjjFqgtmsVGu8=
Received: by 10.210.133.19 with SMTP id g19mr8018185ebd.83.1210661708765;
        Mon, 12 May 2008 23:55:08 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.255.15])
        by mx.google.com with ESMTPS id d2sm5904261nfc.31.2008.05.12.23.55.05
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 May 2008 23:55:06 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <8c5c35580805120843j9b401f8mfa104806880a51c2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81995>

Dnia poniedzia=C5=82ek 12. maja 2008 17:43, Lars Hjemli napisa=C5=82:
> On 5/12/08, Jakub Narebski <jnareb@gmail.com> wrote:
>>  Dnia niedziela 11. maja 2008 08:56, Lars Hjemli napisa=C5=82:
>>
>>> It seems to me that "projectlist in a single file" and "cache resul=
ts
>>> of filled in @$projlist" are different solutions to the same proble=
m:
>>> rapidly filling a perl datastructure.
>>
>> Well, yes and no.  "Projectlist in single file" is about _static_ da=
ta
>> (which changes only if projects are added, deleted, its description
>> changed; those are usually rare events), and avoiding mainly I/O and
>> not CPU (scanning filesystem for repositories, reading config and
>> description, etc.).
>>
>> "Cache data" is about caching _variable_ data, such as "Last changed=
"
>> information for project.  Caching data instead of caching output
>> (caching HTML) allows to share cache for different presentation of
>> the very same data (e.g. 'history'/'shortlog' vs 'rss').  And for so=
me
>> pages, like project search results, caching HTML output doesn't make
>> much sense, while caching data has it.
>=20
> While I agree that caching search result output almost never makes
> sense, I think it's more important that cache hits requires minimal
> processing. This is why I've chosen to cache the final result instead
> of an intermediate state, but both solutions obviously got some pros
> and cons.

True.  In most cases caching final output is enough.  Only in some
cases caching data is better solution.  I hope that "Gitweb caching"
Git's Google Summer of Code 2008 project would examine this in more
detail.

But please take into account that gitweb performance, and I guess any
git web interface performance, is I/O bound and not CPU bound (at least
according to what I remember from J.H. emails).  So a little more
processing is I think less important than avoiding hitting the repos.


J.H. (kernel.org) gitweb from what I remember does adaptive caching
of HTML output, while Pasky (repo.or.cz) gitweb does data caching only
for projects list page.

>>> This used to be expensive in terms of cache size (similar to k.orgs
>>> 20G), but current cgit solves this by treating the cache as a hash
>>> table; cgitrc has an option to set the cache size (number of files)=
,
>>> each filename is generated as `hash(url) % cachesize` and each file
>>> contains the full url (to detect hash collisions) followed by the
>>> cached content for that url (see
>>> http://hjemli.net/git/cgit/tree/cache.c for the details).
>>
>>
>> I guess that is the simplest solution, but I don't think that is
>> the best solution to have size-limited cache.  For example CPAN Perl
>> module Cache::SizeAwareCache and its derivatives use the following
>> algorithm
>>
>>   The default cache size limiting algorithm works by removing cache
>>   objects in the following order until the desired limit is reached:
>>
>>     1) objects that have expired
>>     2) objects that are least recently accessed
>>     3) objects that that expire next
>=20
> Again, minimal processing is the goal of cgits cache implementation,
> hence the simple solution.

I would really like if some comp-sci could calculate amortized cost
of this solution, and what I think is more important, cost of worst
case and what is the probability of hitting worst case or next to
worst case.

By the way, you have to take into account the time it takes to
calculate hash when comparing performance.  Note that for LRU cache
you can use heap / priority queue, or splice / self organizing binary
tree.

>>> Btw: gitweb and cgit seems to aquire the same features these days:
>>> cgit recently got pagination + search on the project list.
>>
>> I haven't checked what features cgit has lately...
>>
>> Gitweb development seems a bit stalled; I got no response to latest
>> turn od gitweb TODO and wishlist list...

=2E..so you would have to turn for example to git-php, gitorious and
github for inspiration.

> Well, I for one found the wishlist interesting; I've been pondering o=
n
> implementing a graphic log in cgit (inspired by git-forest and
> git-graph), but I refuse to perform a  topo-sort ;-)
>=20
> Hopefully I can exploit the fact that cgit never uses more than one
> commit as starting point for log traversal, combined with heuristics
> on commit date, to enable a fast graphic log that will be correct for
> all but the most pathological cases.

I think if you wait for graphing API to make it into released version,
you (well, cgit) would be able to use it for "fast graphic log".

--=20
Jakub Narebski
Poland
