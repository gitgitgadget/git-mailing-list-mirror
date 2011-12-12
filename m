From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] add update to branch support for "floating
 submodules"
Date: Mon, 12 Dec 2011 11:36:54 -0800
Message-ID: <7vaa6x4m5l.fsf@alter.siamese.dyndns.org>
References: <20111109174027.GA28825@book.fritz.box>
 <7vr51htbsy.fsf@alter.siamese.dyndns.org>
 <20111129220854.GB2812@sandbox-rc.fritz.box>
 <loom.20111210T062013-538@post.gmane.org>
 <7vborhaqgw.fsf@alter.siamese.dyndns.org>
 <CALFF=ZQKRgx_AodBQH17T9cSe_JFtoKie7DoMMfkTXCyCFospw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Leif Gruenwoldt <leifer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 20:37:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaBgN-0002m0-7P
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 20:37:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546Ab1LLTg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 14:36:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64994 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752326Ab1LLTg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 14:36:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA7645A15;
	Mon, 12 Dec 2011 14:36:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PFhDuNvUqHsXu7wBPt7wqUpzozg=; b=Lply5A
	PzUJREnH1DVsxzzOhULMx+PY93G+YH3NMWqrruTCnpBETN+t6H6qE+kPo7vrwnRm
	Xeqyknz0tmT/tUUU1zoxAF78qBZEDq+EY0pugPMfr/n0gtkKu52ehumJW8IQYqv2
	uiad8wCuzPaKyEPV3roKNKoA+bm9nQ+8/ZMco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LCAkkgfiDuPKixSsBGPKT3sowbLeBWsf
	kE/CXbnXdwsMUe//TpX+KUHXZGr1hyzsOuR04Go/HJvlxghWl9gD10q7VthngFBq
	DvTZgEbJEjVn8uK8wV0R7E3hjFBGAQB+dFL5ReCmH4PsZ1CcIuQcU/YNht1t7ZKo
	hneQtGGkSyQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E28335A14;
	Mon, 12 Dec 2011 14:36:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BCCC5A13; Mon, 12 Dec 2011
 14:36:56 -0500 (EST)
In-Reply-To: <CALFF=ZQKRgx_AodBQH17T9cSe_JFtoKie7DoMMfkTXCyCFospw@mail.gmail.com> (Leif
 Gruenwoldt's message of "Sat, 10 Dec 2011 10:27:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A68CBD14-24F8-11E1-8F8F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186937>

Leif Gruenwoldt <leifer@gmail.com> writes:

> On Sat, Dec 10, 2011 at 1:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> So that use case does not sound like a good rationale to require addition
>> of floating submodules.
>
> Ok I will try another scenario :)
>
> Imagine again products A, B and C and a common library. The products are in
> a stable state of development and track a stable branch of the common lib.
> Then imagine an important security fix gets made to the common library. On
> the next pull of products A, B, and C they get this fix for free
> because they were
> floating. They didn't need to communicate with the maintainer of the common
> repo to know this. In fact they don't really care. They just want the
> latest stable
> code for that release branch.
>
> This is how package management on many linux systems works. Dependencies
> get updated and all products reap the benefit (or catastrophe) automatically.

Distro package dependency tracking is a poor analogy for many reasons, but
I'll only touch a few.

If you have a common library L and application packages A, B and C, first
of all, you do not build distro package of A from the sources of A and
L. Instead, package A has a build dependency on package L-devel (in other
words, "in order to build A from the source, you need L-devel package
installed in your build environment"), build A from its source, link it
against L's binary without having the source of L. So the source code
arrangement is very different from the typical submodule case, in that you
do not even need to have A and L appear in the same working tree, let
alone bound in a same superproject as two submodules.

A library L may have two API versions, and application A and B may be
written for its v1.0 and v2.0 API, respectively. Distro packaging makes
the binary package A and B _know_ about their own dependency requirements
by recording "A depends on L (v1.0<=,<v2.0)", "B depends on L (v2.0<=)",
etc.

Naively, one might think that two branches, branch-1.0 and branch-2.0, can
be defined in the repository of L, tell somebody (like "superproject that
covers all the packages in the distro") that A wants branch-1.0 and B
wants branch-2.0 of L respectively, to emulate this, but if one thinks
further, one would realize that it is insufficient. For one thing, it is
unclear what should happen when both A and B are asked to be checked out,
but more importantly, in dependency requirements on real distro packaging,
the application C could say "I want v1.0 API but v1.4 is broken and not
compatible with me", which won't fit on the two-branches model. A
workaround to add more branches to L could be devised but any workaround
cannot be a good solution that allows a random application C among 47
others to dictate how the branch structure of L project should look like.

Fortunately, the dependency management is a solved problem by distro
package management and build systems, and they do so without using
anything from submodules. There is no point reinventing these logic in git
submodules and emulating poorly.

The only remotely plausible analogy around distro packaging would be a
superproject full of all the packages in a distro as its submodules, and
records exact versions of each and every package that goes on a release
CD (or DVD). In that case, you do want to have a central registry that
records what exact version of each package is used to cut the CD and the
mother of all modules superproject could be one way to implement it. But
that is not an example of floating, but is a direct opposite.

This exchange convinced me further that anybody who wishes to use
"floating" is better off either by doing one or both of the following:

 - using "exact" but not updating religiously, as the interdepency
   requirement in their project is not strict; or

 - not using submodules at all, but merely keeping these unrelated A, B, C
   and L as standalone repositories next to each other in the directory
   structure.
