From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git's fascination with absolute paths
Date: Mon, 21 Dec 2009 16:26:19 -0800
Message-ID: <7v637z6ehg.fsf@alter.siamese.dyndns.org>
References: <4B2FC17A.3010705@math.purdue.edu>
 <32541b130912211409j540928c0g8e944fcc05c44f82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: J Chapman Flack <jflack@math.purdue.edu>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 01:26:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMsaE-0001s5-F1
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 01:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbZLVA0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2009 19:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752458AbZLVA0d
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 19:26:33 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59696 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454AbZLVA0c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2009 19:26:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C80B98AC77;
	Mon, 21 Dec 2009 19:26:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EnFL4hpDALCyWtCReRxg5GWa1iE=; b=dbr9BE
	n27uyM8Krb3/nTsKZczoSqq2bbnbM8ralA1hdoyZV1tGqhG4JyDbumGJ9KeCnMTS
	QdAuBhbJYj5a1a4Z25eWvdGNcs5gxeuLjdPx8r/Gi9BZm68Cg6dcmJhAcyH6MOzY
	0DW3MeK79D56Y0GIAoOj+CubGyx3Pu+KPHIFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pM1ArDR/WKV7G0drvnvRHKRaGkH9b8I0
	w3NxSByFYTkxyIafTn466u5B5uQWcKYucoTQTK35JmiepBqsyCJYUtjXUUT6b3U9
	QPZJtJF+0NJJ5fMlQJ0T2ZXBGtDs6jIq49e0/SFkGKeq3AZP3KMgs4R7qDJiAbv2
	Yc6zz5sWpnI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 90FB18AC76;
	Mon, 21 Dec 2009 19:26:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A38478AC75; Mon, 21 Dec
 2009 19:26:21 -0500 (EST)
In-Reply-To: <32541b130912211409j540928c0g8e944fcc05c44f82@mail.gmail.com>
 (Avery Pennarun's message of "Mon\, 21 Dec 2009 17\:09\:29 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A3A04E4A-EE90-11DE-B357-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135569>

Avery Pennarun <apenwarr@gmail.com> writes:

> On Mon, Dec 21, 2009 at 1:42 PM, J Chapman Flack <jflack@math.purdue.edu> wrote:
>> In general it seems best for a program to stay free of assumptions
>> about absolute paths except when there is a specific functional
>> requirement that needs them.  I assume there is something git does
>> that requires it to have this limitation, but it's not intuitive
>> to me if I just think about what I expect an scm system to do.
>> I've searched on 'absolute' in the list archive to see if there
>> was a past discussion like "we've decided we need absolute paths
>> everywhere because X" but I didn't find any.  Can someone
>> describe what the reasoning was?  A security concern perhaps?
>> (And one more serious than the race condition built into
>> make_absolute_path?)
>
> I think it's probably just because it's easier to deal with absolute
> paths than relative ones.  Those ".." things can be annoying,
> particularly inside scripts, etc, and git uses a lot of scripts.  Much
> more straightforward to just normalize all the paths once and be sure
> there are no weird dots in them.

Not really.  The scripts can work with ".." just fine, as long as they
know how to use "cd_to_topdir" and "rev-parse --show-prefix" correctly.

While I do not necessarily agree with the original claim that hiding
higher level of hierarchies are "standard" practice in UNIX (it instead
falls into "an unusual set-up that is permitted but you have to be
careful" category), I don't think it is fundamental that we need read
access all the way up to the root level.  It is only that getcwd(3) does.

At the basic work tree and index operations operate relative to the root
of the work tree.  Originally, almost no privision was made to run from a
subdirectory of a work tree (you were expected to run from the top-level,
having ./.git as the meta information sture), and we didn't have to run
any getcwd(3).  Later we added "look at parent directories until we find
the one that has .git subdirectory, while remembering how many levels we
went up", in order to support operations from a subdirectory of a work
tree.  The commands chdir up to the root of the work tree and would use
the path they climbed as a pathspec to limit the scope of their operation.

While "counting how many levels we went up" can be expressed by a sequence
of "../", turning it to the directory prefix means at some point you would
need to do what getcwd(3) does.  It wants to be able to read ".." to give
you an absolute path.

By rewriting that part of the "root-level-discovery" code to do something
like

 - while test -d .git is not true:
   - stat(".") to get the inum;
   - chdir(".."); and
   - opendir(".") and readdir() to find where we were;

while going up every level, you should be able to construct the prefix
without being to able to read all the way up to the filesystem root.  You
only need to be able to read your work tree.

Admittedly the code complexity got worse later when we added support for
GIT_WORK_TREE and also GIT_CEILING_DIRECTORIES, as they fundamentally need
to know where you are relative to the root of the filesystem tree and need
a working getcwd(3) support, which J Chapman's set-up refuses to give.

Also I wouldn't be surprised if the support for these two features cheat
in order to reduce code complexity by always using absolute paths even in
places where a path relative to the root of the work tree might have
sufficed.
