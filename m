From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git with Lader logic
Date: Fri, 27 Mar 2015 08:39:19 -0700
Message-ID: <xmqqegoawiu0.fsf@gitster.dls.corp.google.com>
References: <5F9B9EBF-CD4D-42A8-8A0C-9806702231A1@icloud.com>
	<loom.20150327T160645-181@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Martin Pettersson <martin@siamect.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 16:39:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbWM4-0002V0-5Q
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 16:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbbC0PjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 11:39:22 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50572 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751471AbbC0PjW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 11:39:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BA023F83A;
	Fri, 27 Mar 2015 11:39:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1Y6mdLA9ASDBZHi/1TowGxbNfzY=; b=sHjpAL
	DwHimhZem4vY8kndeL+S9Hv7czZBFsFtyjqhe80pdE8cDpu4kLCncc60MrM74yVA
	mONOeuDtovJJDqZ4IUv9WuJO8YnZNpKLS/MNqOeXsOlIF8vpmVwL9EKFj6JZI2Zo
	cDvNupwGs2kX0VnAgvQ69d0CDgNg5FyDMECXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FOZVWYpmUdgqbQpJiEh7NeFhHP7gqa7P
	cxCL/As3VEF9u7AYcCY20wrYmDN1JiaswvMLkxPmURNVvUO4brAlo0/LTGicarLb
	bnrs9MmHE4LJ+zOXESqAPJt2kZ507U00P7SvPaAvnti4CY/MjWWWamDUADJ5kZD9
	H9tWZaKVtTg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 23AB83F839;
	Fri, 27 Mar 2015 11:39:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8949F3F836;
	Fri, 27 Mar 2015 11:39:20 -0400 (EDT)
In-Reply-To: <loom.20150327T160645-181@post.gmane.org> (Martin Pettersson's
	message of "Fri, 27 Mar 2015 15:09:15 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6F9E91CC-D497-11E4-BDF8-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266375>

Martin Pettersson <martin@siamect.com> writes:

> I use Git for versioning PLC program written for Beckhoff TwinCAT v2 that 
> saves the files in binary format.  
> You can probably do the same for most other systems as well.   
>   
> My way of doing it is... 
> I have a batch file that starts TwinCAT including a file that tell Twincat to
> open my PLC program and export it into a text based format. 
> After that the script opens git gui and gitk.  
>   
> I have one script like this for each plc program. 
> It is quite effcient, the whole procedure only takes a double click and 
> less than 10 seconds and you have git gui up and you can see your 
> changes in pure text, commit and push.   
> I commit both the exported text files and the binary  because the binary
> is the one I edit.   
> This has been working very well for many years....

Let me check if I got your scheme correctly.

 - You need to track PLC program files, whose native format is
   binary and is not very amenable to textual processing like diff
   and merge

 - But you can tell TwinCat to export that binary file to text (and
   presumably you can tell TwinCat to read that exported text file),
   and the text format is human-readable.

 - You use a script that calls TwinCat to export the binary into
   text as a clean filter, and what is checked into Git is the
   exported text representation.

 - You use another script that calls TwinCat to convert the exported
   text back to the binary as a smudge filter, and what is checked
   out to the working tree is the native binary format file.

Is that what is going on?  I can imagine how that arrangement would
work (after all, that is how clean/smudge filters are designed to be
used).

Thanks.
