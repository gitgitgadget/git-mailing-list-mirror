From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Produce a nicer output in case of sha1_object_info
 failures in ls-tree -l
Date: Thu, 19 Mar 2009 15:13:10 -0700
Message-ID: <7vmybh6u15.fsf@gitster.siamese.dyndns.org>
References: <20090319203002.GA31014@blimp.localdomain>
 <7v4oxp89eb.fsf@gitster.siamese.dyndns.org>
 <20090319220020.GA8433@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 23:15:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkQVw-00073T-EU
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 23:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755756AbZCSWNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 18:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755046AbZCSWNV
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 18:13:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56822 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754065AbZCSWNU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 18:13:20 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 519F2A3FDA;
	Thu, 19 Mar 2009 18:13:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 018E3A3FD9; Thu,
 19 Mar 2009 18:13:12 -0400 (EDT)
In-Reply-To: <20090319220020.GA8433@blimp.localdomain> (Alex Riesen's message
 of "Thu, 19 Mar 2009 23:00:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 25D54D4A-14D3-11DE-855A-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113848>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Thu, Mar 19, 2009 22:55:56 +0100:
>> Alex Riesen <raa.lkml@gmail.com> writes:
>> > @@ -91,6 +90,7 @@ static int show_tree(const unsigned char *sha1, const char *base, int baselen,
>> >  	if (!(ls_options & LS_NAME_ONLY)) {
>> >  		if (ls_options & LS_SHOW_SIZE) {
>> >  			if (!strcmp(type, blob_type)) {
>> > +				unsigned long size = 0;
>> >  				sha1_object_info(sha1, &size);
>> >  				printf("%06o %s %s %7lu\t", mode, type,
>> >  				       abbrev ? find_unique_abbrev(sha1, abbrev)
>> 
>> Hmm, shouldn't you be checking the return value from sha1_object_info()
>> and skipping the printf() altogether instead?
>
> But then I cannot know the name of the failed tree entry.

Why?

	if (sha1_object_info() == OBJ_BAD)
		die("object recorded at tree entry %s is bad", pathname);
	printf ...
