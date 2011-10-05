From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-cherry-pick and git-commit --amend in version 1.7.6.4
Date: Wed, 05 Oct 2011 14:55:35 -0700
Message-ID: <7vpqib5ciw.fsf@alter.siamese.dyndns.org>
References: <4E8C6F2F.1070306@6wind.com>
 <7v8voz8hgq.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dyn3kk7SfNZzxjoD-hK9jBQr2igmOqJojeYNHLubtSY=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, nicolas.dichtel@6wind.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 23:55:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBZRJ-0007eV-2Z
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 23:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935423Ab1JEVzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 17:55:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42756 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934884Ab1JEVzi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 17:55:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 890E766B7;
	Wed,  5 Oct 2011 17:55:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y/F7TyxOJ5YvRvMBY/GJ44Uas3E=; b=fe24Js
	IvQvqTG1WBkEg4X8J+ATrkhGR8KhedygMZ+h9xNkWeezpDxlGYTO8aKb0RLDY+TP
	1kZwzxsx7ZDsi9RBuHzZcvf5kmhgLo5qmlvHG3AllHX1/BNHOa8kK/YQjRekeBJc
	DHjtqUKJw5NXefqo0mfYM5Az+rtiTfBIGsO/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rEIg7sFE7TYuF1in/h3ajWLB0TJumifJ
	rgh2IwxxDEvYLawoia9AJi2ppr8RjTLNbo1AitEF/LqVKiQjHg6o+oiwQjP0ID9k
	NoR4AqwoOCl+6Jgo1Lgq7QAxJMcGdw54PUVkG/WUvt8zkcch1xGye2j4LKdBGiEX
	Qc19bkUfIiI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8100C66B6;
	Wed,  5 Oct 2011 17:55:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14CFE66B5; Wed,  5 Oct 2011
 17:55:36 -0400 (EDT)
In-Reply-To: <CAG+J_Dyn3kk7SfNZzxjoD-hK9jBQr2igmOqJojeYNHLubtSY=w@mail.gmail.com> (Jay
 Soffian's message of "Wed, 5 Oct 2011 13:43:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2115B94-EF9C-11E0-8612-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182892>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Wed, Oct 5, 2011 at 1:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Pinging Jay who may have know a thing or two from the history leading to
>> 37f7a85 (Teach commit about CHERRY_PICK_HEAD, 2011-02-19).
>
> Yep, I replied to Nicolas' other message.
>
> j.

This is probably different fro Nicolas's use case, but you can easily
trigger:

 $ edit foo.c
 $ EDITOR=: git commit --amend ;# forget to add foo.c
 $ git cherry-pick other
 error: Your local changes to the following files would be overwritten by
 merge:
        foo.c
 Please, commit your changes or stash them before you can merge.
 Aborting
 $ EDITOR=: git commit --amend foo.c
 fatal: You are in the middle of a cherry-pick -- cannot amend.

I think the sequencer state needs to be removed when the command aborts.

This needs to be fixed before 1.7.7.1.
