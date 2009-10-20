From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ident hash usage question
Date: Tue, 20 Oct 2009 13:43:05 -0700
Message-ID: <7veioxn6ee.fsf@alter.siamese.dyndns.org>
References: <76c5b8580910201024x58ffdd3bs6f4cc6932ac31868@mail.gmail.com>
 <81b0412b0910201116s694d7877rda872b368f1ae09a@mail.gmail.com>
 <81b0412b0910201119w7583487ag276cf964d0a85e@mail.gmail.com>
 <76c5b8580910201159i75a90f28pb882e83f0c7c40ae@mail.gmail.com>
 <81b0412b0910201219q4d16c472n43cab4b5d17cf63c@mail.gmail.com>
 <76c5b8580910201330r45cf625k3a41b5b9e24b3e01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 22:43:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0LYC-0004dB-0s
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 22:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925AbZJTUnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 16:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752878AbZJTUnN
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 16:43:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40586 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbZJTUnL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 16:43:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 93FE87FBD5;
	Tue, 20 Oct 2009 16:43:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UjirBLzlRo8jrlFtdiu71wg9eb4=; b=eejI81
	SO4mktr5m78p4qWjlmmIW8/79T2ncsLrwydBeLa2mQDdiMFVLtb67C2+aSg7kokV
	hJUM9wmi/lEaK27ZJMA4GwdvAxLjHQE8J2gNcSwu4SgHqIYCPkEHHUq2MEBVWm8O
	r9q4MAPewta2HLAkmXiWRVvDeqkTPOaCVR+bs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VrmmyBABaWBzgIkmb6r6bIp64tmuIrrL
	bVeDom/H5lU2ImpnnLuUW/Y9aGQfIjX6t2joMXiFbi0vGSqrRPEUJfM8BgaTHLNc
	XUfU/KkE6OjbuTgIsge/GBsaVj9DcfO/zbuWeLCfOe1QLwtB63Uo82EMPf3GV1g2
	EaCARHDBOT8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 674BB7FBD4;
	Tue, 20 Oct 2009 16:43:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2763F7FBD2; Tue, 20 Oct 2009
 16:43:06 -0400 (EDT)
In-Reply-To: <76c5b8580910201330r45cf625k3a41b5b9e24b3e01@mail.gmail.com>
 (Eugene Sajine's message of "Tue\, 20 Oct 2009 16\:30\:27 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2F0F1F3C-BDB9-11DE-8E9F-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130844>

Eugene Sajine <euguess@gmail.com> writes:

> One of my friends said that git is not working for their development
> model... C++ development with static linking across the board, where
> they need to see exactly which version of the file has got to the
> executable. Roughly, they are using CVS' keywords and revision numbers
> and a script wich matches them between two versions of the
> executables.
>
> I've got curious if Git can support it and how it can be done with
> minimal changes to workflow.

If the project is already arranged to be compiled with decent automation,
I do not think you need any change to the workflow.

You would have a version.cc file with

	static char program_version[] = "My Program " VERSION_STRING;

in it, and teach the build procedure how to compile and link this file.
Something like:

    version.o: version.cc
    	$(CXX) -o $@ -DVERSION_STRING=\""$(git describe HEAD)"\" $?
