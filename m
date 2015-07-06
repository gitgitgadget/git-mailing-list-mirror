From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v6 2/7] cherry-pick: treat CHERRY_PICK_HEAD and REVERT_HEAD
 as refs
Date: Mon, 06 Jul 2015 18:00:30 +0200
Message-ID: <559AA61E.1010308@alum.mit.edu>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com> <1435609076-8592-3-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 18:00:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC8p8-0001cW-IV
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 18:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbbGFQAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 12:00:46 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:56927 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750905AbbGFQAp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jul 2015 12:00:45 -0400
X-AuditID: 1207440c-f79e16d000002a6e-ba-559aa620cb3d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id DD.0E.10862.026AA955; Mon,  6 Jul 2015 12:00:32 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB05DB.dip0.t-ipconnect.de [93.219.5.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t66G0Vx7016091
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 6 Jul 2015 12:00:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1435609076-8592-3-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsUixO6iqKuwbFaowdJVhhbzN51gtOi60s3k
	wOSx4Pl9do/Pm+QCmKK4bZISS8qCM9Pz9O0SuDNe/rjKXvBTuKL7Tj9zA+NK/i5GTg4JAROJ
	y9vWskHYYhIX7q0Hsrk4hAQuM0pcfPKNCcI5yyTx8mo7WBWvgLbEyTfPWbsYOThYBFQl9s9W
	AgmzCehKLOppZgIJiwoESbx+mQtRLShxcuYTFhBbRMBB4vKuo8wgtrBApMSBtnOsEOObGSWu
	3FnBCJLgFPCQ+Pv6JzuIzSygJ7Hj+i9WCFteYvvbOcwTGPlnIZk7C0nZLCRlCxiZVzHKJeaU
	5urmJmbmFKcm6xYnJ+blpRbpGurlZpbopaaUbmKEBCTPDsZv62QOMQpwMCrx8G6omxkqxJpY
	VlyZe4hRkoNJSZTXf9GsUCG+pPyUyozE4oz4otKc1OJDjBIczEoivI+mA+V4UxIrq1KL8mFS
	0hwsSuK8qkvU/YQE0hNLUrNTUwtSi2CyMhwcShK8jEuBGgWLUtNTK9Iyc0oQ0kwcnCDDuaRE
	ilPzUlKLEktLMuJBERlfDIxJkBQP0F4ukHbe4oLEXKAoROspRkUpcV5WkIQASCKjNA9uLCzN
	vGIUB/pSmFcPpIoHmKLgul8BDWYCGrxcF2xwSSJCSqqB0XvRuZ3vZm966Go9s2Rr/AT2iGcC
	53Vnyy2cfbn+//fFbeWMi15yOLG8l2ieILzhZ9m8nbsOvgp783pv5IPpZb6BIS2bDObO23nu
	VMytL0/F9bQOlh4x+NuuLC9lPLv/1OeewoNN9+8kiqTOWHhY5+U5wYAmae6PfBHs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273394>

On 06/29/2015 10:17 PM, David Turner wrote:
> Instead of directly writing to and reading from files in
> $GIT_DIR, use ref API to interact with CHERRY_PICK_HEAD
> and REVERT_HEAD.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  branch.c                         |  4 ++--
>  builtin/commit.c                 |  6 +++---
>  builtin/merge.c                  |  2 +-
>  contrib/completion/git-prompt.sh |  4 ++--
>  git-gui/lib/commit.tcl           |  2 +-
>  sequencer.c                      | 39 ++++++++++++++++++++-------------------
>  t/t7509-commit.sh                |  4 ++--
>  wt-status.c                      |  6 ++----
>  8 files changed, 33 insertions(+), 34 deletions(-)
> 
> [...]
> diff --git a/sequencer.c b/sequencer.c
> index f8421a8..44c43e5 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -158,21 +158,22 @@ static void free_message(struct commit *commit, struct commit_message *msg)
>  	unuse_commit_buffer(commit, msg->message);
>  }
>  
> -static void write_cherry_pick_head(struct commit *commit, const char *pseudoref)
> +static void write_cherry_pick_head(struct commit *commit, const char *ref)
>  {
> -	const char *filename;
> -	int fd;
> -	struct strbuf buf = STRBUF_INIT;
> +	struct strbuf err = STRBUF_INIT;
> +	void *transaction;
>  
> -	strbuf_addf(&buf, "%s\n", sha1_to_hex(commit->object.sha1));
> +	transaction = ref_transaction_begin(&err);
> +	if (!transaction)
> +		die(_("Could not create transaction: %s"), err.buf);
>  
> -	filename = git_path("%s", pseudoref);
> -	fd = open(filename, O_WRONLY | O_CREAT, 0666);
> -	if (fd < 0)
> -		die_errno(_("Could not open '%s' for writing"), filename);
> -	if (write_in_full(fd, buf.buf, buf.len) != buf.len || close(fd))
> -		die_errno(_("Could not write to '%s'"), filename);
> -	strbuf_release(&buf);
> +	if (ref_transaction_update(transaction, ref, commit->object.sha1,
> +				   NULL, REF_NODEREF, NULL,
> +				   &err))
> +		die(_("Could not write ref %s: %s"), ref, err.buf);
> +
> +	if (ref_transaction_commit(transaction, &err))
> +		die(_("Could not commit ref write %s: %s"), ref, err.buf);
>  }

I didn't check all the details, but this code looks a lot like what
update_ref() does. Maybe you can use that function?

>  static void print_advice(int show_hint, struct replay_opts *opts)
> @@ -186,7 +187,7 @@ static void print_advice(int show_hint, struct replay_opts *opts)
> [...]

Otherwise, looks good to me.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
