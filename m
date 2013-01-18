From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t9902 fails
Date: Fri, 18 Jan 2013 08:49:22 -0800
Message-ID: <7v8v7qsagd.fsf@alter.siamese.dyndns.org>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com>
 <20130115232400.GA16147@sigill.intra.peff.net> <50F64597.2070100@web.de>
 <201301172347.50157.avila.jn@gmail.com> <20130118000454.GI13449@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 17:49:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwF8V-00083f-88
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 17:49:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859Ab3ARQt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 11:49:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50269 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751654Ab3ARQt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 11:49:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51131B7E0;
	Fri, 18 Jan 2013 11:49:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bVTknyZVF4dCBonYRpmAdaTi19Y=; b=xWogZa
	lq8HyXBSsWgQsHnDanS8K5pqdeEV4HQsxhpxBzRV+TMag7XkEoppHA8DWh6VWXyB
	op7ruVXl2NaHlPR+ewNfQcEOBo9++DhpmtxBJY5w7HTXosgmTPetYfZCxv683t0V
	AA5hq1LUW6znKxovbP+q3jPRfBw9XSsFlZNwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=omyLXErPle9Ml4hl78G1bhNJ0WhDwXbU
	FIZRB+Q90TTsK+abFixsG5YUAYQR1+wfwGs16epo4AcRVdX63VYxOz3FTEBJpu4z
	TnI5hTEMmop1NuN7WAeFF1cGQiHHigbrQ4p6kctf4BxKDkQdVUPIPLEEHDFtb2bS
	MLdbiuwxv7M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42EBAB7DF;
	Fri, 18 Jan 2013 11:49:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2E17B7DE; Fri, 18 Jan 2013
 11:49:24 -0500 (EST)
In-Reply-To: <20130118000454.GI13449@google.com> (Jonathan Nieder's message
 of "Thu, 17 Jan 2013 16:04:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03D0D37E-618F-11E2-9CE0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213916>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Here's a patch to make the tested command a little less likely to
> conflict with commands from the user's $PATH.  I'm not thrilled with
> it because the contents of $PATH are still not tightly controlled, and
> this does nothing to avoid problems due to existence of, for example,
> a "git cherry-pick-branches" command.
>
> Thoughts?

How about doing something like this and set that variable in the
test instead?  If STD_ONLY is not set, you will get everything, but
when STD_ONLY is set, we will stop reading from "help -a" when it
starts listing additional stuff.

 contrib/completion/git-completion.bash | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a4c48e1..415a078 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -534,7 +534,8 @@ __git_complete_strategy ()
 __git_list_all_commands ()
 {
 	local i IFS=" "$'\n'
-	for i in $(git help -a|egrep '^  [a-zA-Z0-9]')
+	for i in $(LANG=C LC_ALL=C git help -a |
+		   sed -n ${GIT_HELP_STD_ONLY+-e /^git.*elsewhere/q} -e '/^  [a-zA-Z0-9]/p')
 	do
 		case $i in
 		*--*)             : helper pattern;;
