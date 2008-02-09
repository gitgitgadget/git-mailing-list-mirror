From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http.c: guard config parser from value=NULL
Date: Sat, 09 Feb 2008 13:09:34 -0800
Message-ID: <7vabm9et0x.fsf@gitster.siamese.dyndns.org>
References: <5d46db230802081639n78aab3b2s1e83ab9c4afc6a38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Govind Salinas" <blix@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 22:10:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNwxj-0004vI-05
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 22:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755352AbYBIVJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 16:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755033AbYBIVJk
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 16:09:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40256 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937AbYBIVJj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 16:09:39 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B66593E2B;
	Sat,  9 Feb 2008 16:09:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B6B33E2A;
	Sat,  9 Feb 2008 16:09:36 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73267>

"Govind Salinas" <blix@sophiasuchtig.com> writes:

> Signed-off-by: Govind Salinas <blix@sophiasuchtig.com>
> ---
>  http.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/http.c b/http.c
> index d2c11ae..0a2c1c8 100644
> --- a/http.c
> +++ b/http.c
> @@ -92,6 +92,9 @@ static void process_curl_messages(void)
>
>  static int http_options(const char *var, const char *value)
>  {
> +	if (!value)
> +		return git_default_config(var, value);
> +
>  	if (!strcmp("http.sslverify", var)) {
>  		if (curl_ssl_verify == -1) {
>  			curl_ssl_verify = git_config_bool(var, value);

I think this patch is wrong.

You just broke existing repositories with:

	[http]
        	sslverify

to set it to true.
