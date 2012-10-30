From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] =?utf-8?b?cGFyc2VfZGlyc3RhdF9wYXJhbXMoKTo=?= use =?utf-8?b?c3RyaW5nX2xpc3Q=?= to split comma-separated string
Date: Tue, 30 Oct 2012 18:43:51 +0000 (UTC)
Message-ID: <loom.20121030T193428-242@post.gmane.org>
References: <1351443054-10472-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 19:44:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTGnq-0000Y5-Ti
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 19:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932779Ab2J3SoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 14:44:25 -0400
Received: from plane.gmane.org ([80.91.229.3]:43285 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759668Ab2J3SoP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 14:44:15 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TTGnJ-0008HE-60
	for git@vger.kernel.org; Tue, 30 Oct 2012 19:44:13 +0100
Received: from 130.36.62.223 ([130.36.62.223])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 19:44:09 +0100
Received: from kraai by 130.36.62.223 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 19:44:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 130.36.62.223 (Mozilla/5.0 (Windows NT 5.1; rv:18.0) Gecko/18.0 Firefox/18.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208721>

Michael Haggerty <mhagger <at> alum.mit.edu> writes:
...
> -static int parse_dirstat_params(struct diff_options *options, const char ...
> +static int parse_dirstat_params(struct diff_options *options, const char ...
>  				struct strbuf *errmsg)
>  {
> -	const char *p = params;
> -	int p_len, ret = 0;
> +	char *params_copy = xstrdup(params_string);
> +	struct string_list params = STRING_LIST_INIT_NODUP;
> +	int ret = 0;
> +	int i;
> 
> -	while (*p) {
> -		p_len = strchrnul(p, ',') - p;
> -		if (!memcmp(p, "changes", p_len)) {
> +	if (*params_copy)

params_copy is set to the value returned by xstrdup, which cannot be NULL.
This check can be removed and if params_string can be NULL, it should be
checked before being passed to xstrdup.
