From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Verifiable git archives?
Date: Thu, 09 Jan 2014 14:46:44 -0800
Message-ID: <xmqq38kwai3v.fsf@gitster.dls.corp.google.com>
References: <CALCETrU88evB6VQrE8=8vrc+HYXAX8_Zx7TsYZp6YXeE4dZdvg@mail.gmail.com>
	<xmqqsiswapav.fsf@gitster.dls.corp.google.com>
	<CALCETrXTbvHQAWm2z13OwyHCmBZZNDSqyWCdiu6maHRp2mi-Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
X-From: git-owner@vger.kernel.org Thu Jan 09 23:46:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1ONI-0005QL-NJ
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 23:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755082AbaAIWqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 17:46:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39931 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882AbaAIWqs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 17:46:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2BFD62388;
	Thu,  9 Jan 2014 17:46:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JKZZxIa73MDUuO0HlA9lGC5jEtM=; b=jrNT0h
	MS/z0eu59MBzMCwJXeb2p4wg2FI3E6VxEl8eE/Qt1aq8hoVuOUembUPDWJLuX4/L
	GM2IV2liQG6JEFlzYN8+646UtkwEcH4OT/moy1g23S/XpdAUVafvQDgAezKL1IQ+
	YsdFTMXf280Unn7rLRKEK1NKIKaN35/PN7RCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NDw5HEciEiHgTp7auQjWks6JDh7tG/1E
	y1FN4aZu+TpMyGIBci7UiT58Em3VO6GaWQhRJ/EJLWHvMwAqDd7eyRvXx6iI34mM
	1Gxo0Qws/EZJN64b6Bu/g3xy4LxfrvDjNhQyr0B38NaLyliC7nTrsWnLa6dpffbJ
	WNN0LA/xidU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3E6E62387;
	Thu,  9 Jan 2014 17:46:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3718162386;
	Thu,  9 Jan 2014 17:46:47 -0500 (EST)
In-Reply-To: <CALCETrXTbvHQAWm2z13OwyHCmBZZNDSqyWCdiu6maHRp2mi-Pw@mail.gmail.com>
	(Andy Lutomirski's message of "Thu, 9 Jan 2014 12:51:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EBA23AD6-797F-11E3-A388-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240282>

Andy Lutomirski <luto@amacapital.net> writes:

>> You only need the object name of the top-level tree.  After "untar"
>> the archive into an empty directory, make it a new repository and
>> "git add . && git write-tree"---the result should match the
>> top-level tree the archive was supposed to contain.
>
> Hmm.  I didn't realize that there was enough metadata in the 'git
> archive' output to reproduce the final tree.

We do record the commit object name in the extended header when
writing a tar archive already, but you have to grab the commit
object from somewhere in order to read the top-level tree object
name, which we do not record.

Also, if you used keyword substitution and such when creating an
archive, then the filesystem entities resulting from expanding it
would not match the original.
