From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Improve 'git help' with basic user guide linkss
Date: Fri, 08 Feb 2013 12:53:30 -0800
Message-ID: <7vr4kqzfw5.fsf@alter.siamese.dyndns.org>
References: <6D91D31A093D46869F43DD8D1012F0FB@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git List" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 21:54:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3uxI-0006jq-Pc
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 21:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947046Ab3BHUxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 15:53:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38322 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946936Ab3BHUxd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 15:53:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85C7EB42C;
	Fri,  8 Feb 2013 15:53:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rOdc2mTLV9g15ISuZ+OUliMUsig=; b=ARaNFS
	qb9+awpjEDqTqjce+VOp8rPQUjXldkJJNnBFUwTXmwwPopBVubeQRh7o9BiHfpQN
	a+EthkN6ZR7peyGmmXey5ffUHMIiv0vCq+kxsqMaX9bvyyfRPdnFvH30+WhYD9zC
	ERvXx50iVdTeccbGNVl9LbQoPvSnQG5IE6ykE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EZo0rs+ryFYJUUDc1u71jEd2o6Ub0hob
	2MFVhO9OHZTe9W7otnu73mzzVLFmkFiTGPcqmwtUS4f/5XHtILDkVAJz8MqPatFO
	RTSZLys99sVoBWS6gvJz7/DAFgAK0Nc271Iyw4FyBWajcwoIss9jKYYv3SYjSCRD
	QE/md32fEpo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B63DB42B;
	Fri,  8 Feb 2013 15:53:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF7D2B429; Fri,  8 Feb 2013
 15:53:31 -0500 (EST)
In-Reply-To: <6D91D31A093D46869F43DD8D1012F0FB@PhilipOakley> (Philip Oakley's
 message of "Fri, 8 Feb 2013 20:28:39 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98EE0EB0-7231-11E2-B8F8-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215817>

"Philip Oakley" <philipoakley@iee.org> writes:

> I'm looking at extending the 'git help' to include some information
> for the basic user who isn't ready for the extensive man page
> documentation for the various commands.

We have pointers at the beginning of "git(1)" for that exact reason.
I am not saying the documents pointed at from there are perfect, but
shouldn't that approach work?

> My real question is on the right approach to generating a list of
> guides and including them into the git help options. I'm planning on
> extending the command-list.txt file to include 'guides' and then
> extending the generate-cmdlist.sh to generate a guides array in
> common-cmds.h.

Having a catalog of guide documents in help.o sounds like a good way
to go, but I doubt "command-list" is a good place to store it.  It
is about git subcommands, "git help -a" uses it to show the list of
them, and the bash completion support uses the list via "git help -a".

The common-cmds.h does not have to be the only avenue to add your
catalog of guide documents to help.o. As a part of the build
procedure, you can list Documentation/guides/ and generate an array
definition into "guides.h", and add #include "guides.h" in help.c,
for example.

> I'm thinking of adding -g --guides and -c --commands options to
> complement the existing -a --all (becomes both commands and guides)

Complement is fine.  Contaminating -a with guides is probably not.

> I was expecting to update the user-manual. to become
> gituser-manual.txt so that the existing 'git help user-manual' scheme
> would discover it. The Tutorial and the User manual obviously(?) being
> the first port of call for the confused user.

Again, we do have pointer to tutorial fairly prominently at the
beginning of "git(1)".  Perhaps we want index.html that redirects to
git.html or something?
