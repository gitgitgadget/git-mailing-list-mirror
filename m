From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for
 push.default
Date: Sat, 10 Mar 2012 13:05:32 -0800
Message-ID: <7v62ec2mlf.fsf@alter.siamese.dyndns.org>
References: <1kgpkt9.lt61vy108h530M%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: marcnarc@xiplink.com (Marc Branchaud),
	cmn@elego.de (Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto),
	Matthieu.Moy@imag.fr (Matthieu Moy), git@vger.kernel.org
To: lists@haller-berlin.de (Stefan Haller)
X-From: git-owner@vger.kernel.org Sat Mar 10 22:06:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6TV6-0003IF-E6
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 22:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286Ab2CJVGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Mar 2012 16:06:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48322 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752210Ab2CJVFf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2012 16:05:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E189860D1;
	Sat, 10 Mar 2012 16:05:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wAggoIp298ivagepbXLHBGF31q0=; b=UzoIoC
	O+0tzMkPqxl9seZt09818OIxGvczIplswnmMBkv4Dl1f+jiZys0Rf5vOlA6VxtyT
	odb88mz5OhZn4EyVYYmkIFsNONgCJd4BEWp0komsY2HR38c4MpB7lBHsuNhhr3yR
	oslIkM2Ip3pz9DK0kMQnJt9WCl7/0ziTS2soY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cgh/CV7RqzD5J/fnlXVCUzEhtHnx7INO
	IzV8n/rJg4WOPsSBJYrh5l4BsCXwaM4As4ArT7OGJszXsJVsWsEdLiJ3a5Yfv934
	1geEYIaD67nzyEH5A3LCGZrcsQVaKajiXJxYUbWxdpnVWcRalUxDksdz9TI47fXr
	qAP61QfjeE0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D65B360D0;
	Sat, 10 Mar 2012 16:05:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 392DC60CE; Sat, 10 Mar 2012
 16:05:34 -0500 (EST)
In-Reply-To: <1kgpkt9.lt61vy108h530M%lists@haller-berlin.de> (Stefan Haller's
 message of "Fri, 9 Mar 2012 22:08:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C71575DE-6AF4-11E1-B02F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192786>

lists@haller-berlin.de (Stefan Haller) writes:

> Marc Branchaud <marcnarc@xiplink.com> wrote:
>
>> I think that an incantation like
>> 
>>   git checkout -b topic origin/master
>> 
>> makes it pretty clear that topic is meant to be merged into origin's 
>> master branch.  And so a simple "git push" as you describe I think 
>> *should* update origin's master branch.
>
> Not for us, no.  (But this is maybe a different topic.)
>
> In our workflow (centralized repository), we never ever have a local
> branch with a different name than its upstream branch. Never.
>
> When we say
>
>   git checkout -b topic origin/master
>
> then it's always a mistake, and what we really meant was
>
>   git checkout -b --no-track topic origin/master

It would have been nice if you explained larger picture of your
workflow, as almost anything else in life, a blanket statement like
the above is not a universal truth.  It is clear you were aware of
that from your "Not for *us*", there is not enough clue for others
to tell if their workflow is similar to yours to decide if the above
rule of thumb of yours is a good one to follow for them.

Let's illustrate what I mean by "explain larger picture of workflow"
with a few examples.

An example of where "checkout -b topic origin/master" would not be a
mistake is when it is the norm for your project for contributors to
integrate their work with "pull --rebase", it is perfectly sensible
for a contributor to

	git checkout -b frotz origin/master

to start working on his feature "frotz", and way before the feature
becomes ready, starting to work on unrelated feature "nitfol" with

	git checout -b nitfol origin/master

and keep building these in parallel, running "git pull --rebase" to
float yet-to-be-published his own work on updated the shared history
before continuing to work on a topic until the feature is done.  As
the contributor may not know upfront which of these independent
features will become ready when he starts working, it is sensible
to be on the latter "nitfol" topic and "git push" it to update the
shared history with the finished work on the branch.

In this case, you would want "git push" a branch to its @{upstream}.

Another example that "checkout -b topic origin/master" would not be
a mistake is when you fork your favorite project at GitHub, work on
two independent topics. You work the same way as the above (you may
not "pull --rebase", though), and then push both of them out and ask
them to be pulled "Please pull my 'frotz' and 'nitfol' branches".

In this case, you would want "git push" a branch to update the
branch with the same name (i.e. either 'current' or 'matching').
