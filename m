From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Documentation: git log: --exit-code undocumented?
Date: Mon, 01 Dec 2014 09:49:25 -0800
Message-ID: <xmqqwq6bp8ey.fsf@gitster.dls.corp.google.com>
References: <87zjb78u7g.fsf@osv.gnss.ru>
	<xmqqegsjqqox.fsf@gitster.dls.corp.google.com>
	<874mtfl1hx.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Dec 01 18:50:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvV6z-0000xA-O9
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 18:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438AbaLARuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 12:50:04 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62150 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751868AbaLARuD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 12:50:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E17020797;
	Mon,  1 Dec 2014 12:50:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yx1eRYhhbS81x5sVWpcuopayqTk=; b=fOtxcr
	JFRNOswGG6XfrPnfmXwZeLYv8iF7PEpfW3hMkVj8icGf0aqUC0Vfo/zXa73dAUOj
	kooD3BC6BONb21NGr9NLPGcONB3ifrjCjpyaNj9qlnMP3wsYRgSVszl+kE15uw74
	mDH9icxvOBz+Kt7WszkBw17b9T70OVbyYFC6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B1MQhnqLHseZcAi/Ef1Rw0BUWA7GEkk5
	9It2IJwQ/HXNpZAwORjl/6fjBoUFsICdYM8csdAgFzjYeAc1NSWtexfPD9hE+DYl
	zBbRh3N9vdk0iteScR/LjhtPJ+9qhnkrkEA3qrrsHAvNW5CSUL61AekmeiEQq63z
	oFDElVg2vww=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E88A20794;
	Mon,  1 Dec 2014 12:50:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A8A1B20694;
	Mon,  1 Dec 2014 12:49:26 -0500 (EST)
In-Reply-To: <874mtfl1hx.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Mon, 01 Dec 2014 18:32:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6483C084-7982-11E4-96C5-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260499>

David Kastrup <dak@gnu.org> writes:

> I disagree that --exit-code does nothing: it indicates whether the
> listed log is empty.  So for example
>
> git log -1 --exit-code a..b > /dev/null
>
> can be used to figure out whether "a" is a proper ancestor of "b" or
> not.

Hmph.

    $ git log --exit-code master..maint >/dev/null; echo $?
    0
    $ git log --exit-code maint..master >/dev/null; echo $?
    1

That is a strange way to use --exit-code.  I suspect that if you did
this, you will get 0 from the log between HEAD~..HEAD

    $ git checkout master^0
    $ git commit --allow-empty -m empty
    $ git log --exit-code HEAD~..HEAD

even though HEAD~ is a proper ancestor of HEAD, so it is not giving
us anything useful.  Isn't it a mere artifact that "log" happens to
share the underlying machinery with "diff" that --exit-code shows a
non-zero exit when there is any single commit in the range that has
any change?
