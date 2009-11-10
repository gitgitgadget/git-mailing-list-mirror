From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 20/24] http-fetch: add missing initialization of
 argv0_path
Date: Tue, 10 Nov 2009 12:12:39 -0800
Message-ID: <7vpr7q6sw8.fsf@alter.siamese.dyndns.org>
References: <20091109150235.GA23871@progeny.tock>
 <1257779104-23884-20-git-send-email-jrnieder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 21:12:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7x5B-0000un-Oy
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 21:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758034AbZKJUMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 15:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758031AbZKJUMn
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 15:12:43 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49785 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757992AbZKJUMm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 15:12:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6713D9A9F7;
	Tue, 10 Nov 2009 15:12:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=6/SycUlPf52d7MQ8MiwdGo8Znn4=; b=ji1ZXeJ6TX6GtwIK4tK0cKn
	0s3ogH2cj3Yf9n9r1B1TL9ZyQEB62N5iMYmX6x45t1yxaDUrOzP/lXH9h3O4bt4I
	Eu6urTzdOy8i1n0SxnYmNmDGMjrD0GMbw7MwMDg7uQKg9iYWLTTqmpvU7zze6ZC7
	r+zhxsfQc4RsX+pCRm0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=rpzfjEyDOG79T4Pw8e/9SSWKmU1ZtXgaEJjRIeyCLWGcqZCqr
	8C762+MKqR2jSKdsSZmPSTq4UTHgzN7W0s9CovrSQ6tF7LQyPF6fmOH5jWl4Ze7V
	wL953P3uESFY7xEjpncFAa7MLQ6g43alvWhbKZhPCXVNRWWO8i5dLk+8Io=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 37A369A9F6;
	Tue, 10 Nov 2009 15:12:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DAA3E9A9F2; Tue, 10 Nov 2009
 15:12:40 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 68A3EC46-CE35-11DE-8336-BD45BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132591>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---

Why do you have inclusion of "exec_cmd.h" in [19/24]?  As far as I can
tell, nothing you do in that patch depends on it.

According to c6dfb39 (remote-curl: add missing initialization of
argv0_path, 2009-10-13), this patch is necessary (and you must include
"exec_cmd.h") on MinGW, regardless of the "give help upon -h" topic.

I think this should be ejected from your series go directly to 'maint', or
am I mistaken?

 http-fetch.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index e8f44ba..88f7dc8 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "exec_cmd.h"
 #include "walker.h"
 
 int main(int argc, const char **argv)
@@ -19,8 +20,8 @@ int main(int argc, const char **argv)
 	int get_verbosely = 0;
 	int get_recover = 0;
 
+	git_extract_argv0_path(argv[0]);
 	prefix = setup_git_directory();
-
 	git_config(git_default_config, NULL);
 
 	while (arg < argc && argv[arg][0] == '-') {
