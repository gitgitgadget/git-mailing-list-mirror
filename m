From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix safe_create_leading_directories() for Windows
Date: Thu, 02 Jan 2014 11:55:45 -0800
Message-ID: <xmqqtxdmp39a.fsf@gitster.dls.corp.google.com>
References: <52C5A039.6030408@gmail.com>
	<alpine.DEB.1.00.1401021826120.1191@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 02 20:55:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VyoN1-0001Ta-8i
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 20:55:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbaABTzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 14:55:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49734 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136AbaABTzu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 14:55:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CD525EF70;
	Thu,  2 Jan 2014 14:55:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PCDwStNn9FNLlt1mKhceajGZjwI=; b=fhWnEJ
	BX6tVdTLg1g9+lgL7gzlcOCvpGpnsrj2NvlK+q0mC1zzDDhkayHWQiD0lUAf3iqg
	H3inbu/kQAJ29jCpswb51/7MiYijjg7TCeXJ3t3IRdJrEHScWIs4Wmfny9YDCxOx
	opYh+znNr3VmFhKLyl/i1TJdSPKIf8ogfuSgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oxBwYgxRt0DnAmOIdOkzxcjb5qG9c20P
	Rj1hTdDDirW7tkLAGCB7iQNecdbQ1V60+xqIHsGxkgNMlZFDoC9ptClAOCHvPIdp
	IwngHLfKFz3iIhCjmiewRlovZspHyWvhzsf5kUGt2P0cGQOSSlAsrFPzNl1m6Z8f
	1wCMKG8/vzc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F5B45EF6F;
	Thu,  2 Jan 2014 14:55:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8A405EF6E;
	Thu,  2 Jan 2014 14:55:47 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1401021826120.1191@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Thu, 2 Jan 2014 18:33:31 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DFBD82AE-73E7-11E3-B60F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239869>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 2 Jan 2014, Sebastian Schuberth wrote:
>
>> See https://github.com/msysgit/git/pull/80.
>
> Thanks Sebastian!
>
> However, since the git.git project is not comfortable with the concept of
> pull requests (which is why you submitted this patch via mail), I believe
> that we have to explain the rationale in the commit message. So here goes
> my attempt:

Thanks; the conclusion is correct --- you need a good commit
message in the recorded history.  That does not have anything to do
with integrating with pulling from subsystem maintainers, which we
regularly do.

> On Linux, we can get away with assuming that the directory separator is a
> forward slash, but that is wrong in general. For that purpose, the
> is_dir_sep() function was introduced a long time ago. By using it in
> safe_create_leading_directories(), we proof said function for use on
> platforms where the directory separator is different from Linux'.

Perhaps with s|Linux|POSIX|, but more importantly, was there a
specific error scenario that triggered this change?

My quick reading of "git grep" suggests that the callsites of this
function all assume that they are to use slashes as directory
separators, and it may be that it is a bug in the specific caller
that throws a backslash-separated paths to it.
