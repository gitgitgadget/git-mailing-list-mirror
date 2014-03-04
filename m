From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH] [PATCH] commit.c: Replace =?utf-8?b?c3RhcnRzX3dpdGgoKQ==?= with =?utf-8?b?c2tpcF9wcmVmaXgoKQ==?=
Date: Tue, 4 Mar 2014 17:31:12 +0000 (UTC)
Message-ID: <loom.20140304T182823-503@post.gmane.org>
References: <1393948445-24689-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 18:35:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKtFm-0000ao-28
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 18:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034AbaCDRfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 12:35:07 -0500
Received: from plane.gmane.org ([80.91.229.3]:49111 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753025AbaCDRfG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 12:35:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WKtF9-0008RT-2I
	for git@vger.kernel.org; Tue, 04 Mar 2014 18:35:05 +0100
Received: from triband-del-59.178.55.90.bol.net.in ([triband-del-59.178.55.90.bol.net.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 18:35:03 +0100
Received: from tanayabh by triband-del-59.178.55.90.bol.net.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 18:35:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 59.178.55.90 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Firefox/24.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243360>


Karthik Nayak <karthik.188 <at> gmail.com> writes:

> 
> In record_author_date() :
> Replace "buf + strlen(author )" by skip_prefix(), which is
> saved in a new "const char" variable "indent_line".
> 
> In parse_signed_commit() :
> Replace "line + gpg_sig_header_len" by skip_prefix(), which
> is saved in a new "const char" variable "indent_line".
> 
> In parse_gpg_output() :
> Replace "buf + strlen(sigcheck_gpg_status[i].check + 1)" by
> skip_prefix(), which is saved in already available
> variable "found".
> 
> Signed-off-by: Karthik Nayak <karthik.188 <at> gmail.com>
> ---
>  commit.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/commit.c b/commit.c
> index 6bf4fe0..71a03e3 100644
> --- a/commit.c
> +++ b/commit.c

>  <at>  <at>  -1098,6 +1100,7  <at>  <at>  int parse_signed_commit(const
unsigned char *sha1,
>  	char *buffer = read_sha1_file(sha1, &type, &size);
>  	int in_signature, saw_signature = -1;
>  	char *line, *tail;
> +	const char *indent_line;
> 
>  	if (!buffer || type != OBJ_COMMIT)
>  		goto cleanup;
>  <at>  <at>  -1111,11 +1114,11  <at>  <at>  int parse_signed_commit(const
unsigned char *sha1,
>  		char *next = memchr(line, '\n', tail - line);
> 
>  		next = next ? next + 1 : tail;
> +		indent_line = skip_prefix(line, gpg_sig_header);
>  		if (in_signature && line[0] == ' ')
>  			sig = line + 1;
> -		else if (starts_with(line, gpg_sig_header) &&
> -			 line[gpg_sig_header_len] == ' ')
> -			sig = line + gpg_sig_header_len + 1;
> +		else if (indent_line && indent_line[1] == ' ')
> +			sig = indent_line + 2;
>  		if (sig) {
>  			strbuf_add(signature, sig, next - sig);
>  			saw_signature = 1;


Hi,

I was attempting the same microproject so I thought I would share some
points that were told to me earlier .The mail subject should have a
increasing order of submission numbers for each revision(for example here it
should be [PATCH v2]).

Also write the superfluous stuff which you have written in the bottom  
after ---(the three dashes after the signed off statement) .

In the parse_signed_commit() function, gpg_sig_header_len and gpg_sig_header
variables are precomputed outside of the function, and also Junio said to
prefer starts_with(), whenever skip_prefix() advantages are not so important
in the context.So the replace may not be so advantageous ,I may be wrong in
this case.

 

Cheers,
Tanay Abhra.
