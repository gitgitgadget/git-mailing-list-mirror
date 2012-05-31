From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove perl dependency from git-submodule.sh
Date: Thu, 31 May 2012 10:49:41 -0700
Message-ID: <7vpq9k6y16.fsf@alter.siamese.dyndns.org>
References: <1338454126-30441-1-git-send-email-iveqy@iveqy.com>
 <4FC73788.6070805@viscovery.net>
 <20120531104036.GB30500@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	jens.lehmann@web.de
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu May 31 19:49:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa9VM-00055e-Vh
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 19:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206Ab2EaRto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 13:49:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44829 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751880Ab2EaRtn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 13:49:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 530598FBB;
	Thu, 31 May 2012 13:49:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KJusdorwAxqKvenLlE+seZOQ9vc=; b=sCnyV/
	Oh9lKuwJu3dJDfb7BZScUp1kF5cPyDsnpmugITaY77M/liwrEasVetai3l3D2ad+
	leB0Tx4VwoThC1vlETON4Lxe8XDO9V42lFjrvbTQ1kjx2Wv7CVB9W0TLdJQ0eW7Q
	q1nVFlvd7i5gfbnoTVHgng36wXRpaZdD1gY5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wHe48DsV6TbDoAKmCcSy4oYEiE7KXeFd
	qQFXjT5GP/U1Pa4uCBKU2/nNsvJ2PzjnzqLo0MTW4K+Pc+wC9DgsOn8y8yfsEkEc
	UrlG2O57TnEFkxrlnzATWYUjD35MAcHHpzfImJO4Wp2e/iNJ4srypaRb6zy7fNGy
	6Mtf92d/Wno=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49E848FBA;
	Thu, 31 May 2012 13:49:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C9C3F8FB9; Thu, 31 May 2012
 13:49:42 -0400 (EDT)
In-Reply-To: <20120531104036.GB30500@paksenarrion.iveqy.com> (Fredrik
 Gustafsson's message of "Thu, 31 May 2012 12:40:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 00925522-AB49-11E1-8DF7-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198930>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> On Thu, May 31, 2012 at 11:19:04AM +0200, Johannes Sixt wrote:
>> Am 5/31/2012 10:48, schrieb Fredrik Gustafsson:
>> > Rewrote a perl section in sh.
>> 
>> > The code may be a bit slower (doing grep on strings instead of using
>> > perl-lists).
>> 
>> "A lot" would be more correct on Windows :-) But it can be avoided, I think.
>> 
>> >  module_list()
>> >  {
>> > +	unmerged=
>> > +	null_sha1=0000000000000000000000000000000000000000
>> >  	git ls-files --error-unmatch --stage -- "$@" |
>> > -	perl -e '
>> > -	my %unmerged = ();
>> > -	my ($null_sha1) = ("0" x 40);
>> > -	while (<STDIN>) {
>> > -		chomp;
>> > -		my ($mode, $sha1, $stage, $path) =
>> > -			/^([0-7]+) ([0-9a-f]{40}) ([0-3])\t(.*)$/;
>> > -		next unless $mode eq "160000";
>> > -		if ($stage ne "0") {
>> > -			if (!$unmerged{$path}++) {
>> > -				print "$mode $null_sha1 U\t$path\n";
>> > -			}
>> > -			next;
>> > -		}
>> > -		print "$_\n";
>> > -	}
>> > -	'
>> > +	while read mode sha1 stage path
>> 
>> Be prepared for backslashes in the path name:
>> 
>> 	while read -r mode sha1 stage path
>
> We are not using -r on any place in git-submodule.sh. Maybe we should? I
> can provide a patch if needed.

I've already written off "git-submodule.sh" script as unfriendly to
pathnames with funny characters in them.  Using "read -r" may work
around backslashes in the path, but you won't be able to sensibly
handle LFs in filenames, for example.  In other words, we could just
tell users "don't use funny pathnames"---and from that point of
view, rewriting the Perl scriptlet with a pure shell implementation
that does not fork other little tools is sensible, especially if it
results in better performance, more readable code, etc.  

Having said that, in the longer term, I think the right direction to
go is the opposite.  It would be better to make "git-submodule.sh"
work better with paths with funny characters in them, and one
obvious approach is to read "ls-files -z" output with something
capable of parsing NUL-terminated records, e.g. a Perl scriptlet.
Adding a new shell loop like this patch only adds one place that
needs to be fixed later when that happens, so I am not sure I like
this patch.
