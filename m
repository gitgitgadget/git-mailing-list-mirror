From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] name-hash.c: fix endless loop with
 core.ignorecase=true
Date: Wed, 27 Feb 2013 16:27:24 -0800
Message-ID: <7vsj4hi8pf.fsf@alter.siamese.dyndns.org>
References: <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
 <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
 <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com>
 <20130210111732.GA24377@lanh>
 <CABPQNSZ282Lre=sy-+ZQdJA9JnGqQguq2bQDOwvjb0fP+1-w8Q@mail.gmail.com>
 <CACsJy8AWyJ=dW5f44huWyPPe4X62xyi+R9CNM5Tg6u6TYf+thQ@mail.gmail.com>
 <511AAA92.4030508@gmail.com>
 <CACsJy8C=2xKcsby048WWCFNhgKObGwrzeCOJPVVqgj88AfSHQw@mail.gmail.com>
 <20130213181851.GA5603@sigill.intra.peff.net> <511BF6D7.3030404@gmail.com>
 <20130213225529.GA25353@sigill.intra.peff.net> <511C3454.6080204@gmail.com>
 <512E1C0F.3050506@gmail.com> <7v621dk8aa.fsf@alter.siamese.dyndns.org>
 <512E8014.3090107@gmail.com> <512E9D7C.2030803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	kusmabite@gmail.com, Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 01:28:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UArLl-0007j4-2L
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 01:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962Ab3B1A12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 19:27:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61873 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751813Ab3B1A11 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 19:27:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2244C511;
	Wed, 27 Feb 2013 19:27:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VF4uNwIZJd0OSMVage/xtGNpw3s=; b=Czbjfz
	bdI887VTRHINFF99gEyvDx9LhUQlWBXWxNRlz+BTLEdT2UfxuIqXSioMZujuXliY
	icnhWpbSmvDB40ree2lWkrL71H6OoIskzZ52fke4UCLaEI/ADTJ8TKh2z0OXS27Y
	Ku+hrMvr6Abflx+qvwHHfiteJ7DbXUhDMZQI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MtxOR3jQDICYdKCc4YM0zqs1jTTvIDYH
	ITUiQpjvKP9dImeEqRb9vdLqh5GXaYJlNSAruW0470pLSG2LEmHe9LOi/cijsKoh
	d4oPNz8hKxl5xzDbWdmD3LmPIg8aaMORQjAu31wK4lD607JFP1WDM8YYn1LhQRjh
	oYOJADpQWbc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5513C50F;
	Wed, 27 Feb 2013 19:27:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BD46C50E; Wed, 27 Feb 2013
 19:27:26 -0500 (EST)
In-Reply-To: <512E9D7C.2030803@gmail.com> (Karsten Blees's message of "Thu,
 28 Feb 2013 00:57:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A094E646-813D-11E2-994A-2B642E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217230>

Karsten Blees <karsten.blees@gmail.com> writes:

> With core.ignorecase=true, name-hash.c builds a case insensitive index of
> all tracked directories. Currently, the existing cache entry structures are
> added multiple times to the same hashtable (with different name lengths and
> hash codes). However, there's only one dir_next pointer, which gets
> completely messed up in case of hash collisions. In the worst case, this
> causes an endless loop if ce == ce->dir_next (see t7062).
>
> Use a separate hashtable and separate structures for the directory index
> so that each directory entry has its own next pointer. Use reference
> counting to track which directory entry contains files.
>
> There are only slight changes to the name-hash.c API:
> - new free_name_hash() used by read_cache.c::discard_index()
> - remove_name_hash() takes an additional index_state parameter
> - index_name_exists() for a directory (trailing '/') may return a cache
>   entry that has been removed (CE_UNHASHED). This is not a problem as the
>   return value is only used to check if the directory exists (dir.c) or to
>   normalize casing of directory names (read-cache.c).
>
> Getting rid of cache_entry.dir_next reduces memory consumption, especially
> with core.ignorecase=false (which doesn't use that member at all).
>
> With core.ignorecase=true, building the directory index is slightly faster
> as we add / check the parent directory first (instead of going through all
> directory levels for each file in the index). E.g. with WebKit (~200k
> files, ~7k dirs), time spent in lazy_init_name_hash is reduced from 176ms
> to 130ms.
>
> Signed-off-by: Karsten Blees <blees@dcon.de>
> ---

One thing that still puzzles me is what guarantee we have on the
liftime of these ce's that are borrowed by these dir_hash entries.
There are a few places where we call free(ce) around "aliased"
entries (only happens with ignore_case set).  I do not think it is a
new issue (we used to borrow a ce to represent a directory in the
name_hash by using the leading prefix of its name anyway, and this
patch only changes which hash table is used to hold it), and I do
not think it will be an issue for case sensitive systems, so I would
stop being worried about it for now, though ;-)

Thanks, will replace and queue.


> diff --git a/t/t7062-wtstatus-ignorecase.sh b/t/t7062-wtstatus-ignorecase.sh
> new file mode 100755
> index 0000000..73709db
> --- /dev/null
> +++ b/t/t7062-wtstatus-ignorecase.sh
> @@ -0,0 +1,20 @@
> +#!/bin/sh
> +
> +test_description='git-status with core.ignorecase=true'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'status with hash collisions' '
> +	# note: "V/", "V/XQANY/" and "WURZAUP/" produce the same hash code
> +	# in name-hash.c::hash_name
> +	mkdir V &&
> +	mkdir V/XQANY &&
> +	mkdir WURZAUP &&
> +	touch V/XQANY/test &&
> +	git config core.ignorecase true &&
> +	git add . &&
> +	# test is successful if git status completes (no endless loop)
> +	git status
> +'
> +
> +test_done
