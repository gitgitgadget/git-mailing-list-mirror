From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge <tag>: Spawning an editor can't be disabled
Date: Thu, 09 Feb 2012 10:11:45 -0800
Message-ID: <7vzkcrx4f2.fsf@alter.siamese.dyndns.org>
References: <20120209153431.GA24033@godiug.sigxcpu.org>
 <20120209160803.GA5742@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 19:12:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvYTQ-00088J-3f
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 19:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758187Ab2BISLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 13:11:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42914 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927Ab2BISLs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 13:11:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A36B06E3E;
	Thu,  9 Feb 2012 13:11:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qzl9OewvuVGfnY2SXaxhhqw+thA=; b=JH5zd4
	q8W0WBQiyjz2uearWeyVP+yiKz3byZXOccWPe7ILwQWAYxCq08wtZiKtJNFUMmN3
	8p4GHB/0bCavpLrgmKrIAQFOYk6/xHPHEgO9NyuQndLpZGttavZkZcjQWRUoTYqO
	pAtpY0JvKoaQpCAFtFu/3M2lJDaerzauaZiTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X373uix9+8ELZZy+YVtPGqQL5baTH3BM
	TAsA7c5jV0wmjS2Hn/459QeLLjGWJjrJdVcGScNGU1weAODMD3BCEbJGwYuNoM1z
	6L6tcXOlWn0jpApgOA+Rf/qShHXt9OzBldWS0XO0L0fITNHRmr9CIMY+mAgzdupx
	ulDPwfhm8VM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A4466E3C;
	Thu,  9 Feb 2012 13:11:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D32A6E3B; Thu,  9 Feb 2012
 13:11:47 -0500 (EST)
In-Reply-To: <20120209160803.GA5742@burratino> (Jonathan Nieder's message of
 "Thu, 9 Feb 2012 10:08:18 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 87AF5102-5349-11E1-A37C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190301>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> as of 1.7.9 merging in a tag unconditionally spawns an editor. I tried
>> turning this of with --no-edit but to no avail. This is a behaviour
>> change that breaks tools like git-buildpackage. I wonder if this should
>> be turned off by default?
>
> Thanks.  I can confirm this: ever since commit fab47d05 (merge: force
> edit and no-ff mode when merging a tag object, 2011-11-07), running
> "git checkout github/maint-1.5.6 && git merge --no-edit v1.7.2"
> launches an editor window despite the caller's request.  And I agree
> that it is counter-intuitive.

Thanks; it is unquestionably a bug that "git merge --no-edit v1.7.2"
spawns an editor.

The real question is what should happen.

If the editor is not spawned, there is no way for the user to review the
result of signature verification before deciding to accept the merge.
"git merge --no-edit v1.7.2" could error out saying "you cannot create
this merge without reviewing".  Or it could behave as if it was asked to
"git merge --no-edit v1.7.2^0", dropping the signature verification and
recording part altogether.
