From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 4/4] notes: teach git-notes about notes.<ref>.merge option
Date: Tue, 11 Aug 2015 20:11:12 -0400
Message-ID: <CAPig+cRCmuxqVSqFfF7v-aOKEohfPjAYFAaos5XOz4uWD_psdQ@mail.gmail.com>
References: <1439326641-9447-1-git-send-email-jacob.e.keller@intel.com>
	<1439326641-9447-5-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 02:11:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPJdV-0003Cf-IP
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 02:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933185AbbHLALN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 20:11:13 -0400
Received: from mail-yk0-f196.google.com ([209.85.160.196]:36756 "EHLO
	mail-yk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932485AbbHLALM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 20:11:12 -0400
Received: by ykay144 with SMTP id y144so105200yka.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 17:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XdVCm/C2aHa8x+yMVr3Vuj4dS4af4SPtavx5jh5AR9o=;
        b=Zl3SJIPiFSWFBX57nL811FVNQC9MmYwyTwwGnUFOh0BE7tDNUCgxbTWxAUAxhreaai
         u4DtMcWk7U4Fdi80KQRsJnCJO8vPSRInDEIZ/vZOP17y+fhaWhggFveQsE31EC3KarZo
         DbMtcRTwdqiGF3Xk2xxIOtFbvfmhh2xHn8chPw9c7ObrJhf/CVtbKHD/BVUp1hRc+DK4
         zfcoQLWYl4JrHDk1QSBh2vfoWos5qlKBNeTt7Tya3kWZ9MRdc/ITd9xY5nlUj7OpnFq7
         XRBnJEXFN+ZKV6K+Rf/8/NDYydP63pmKFhFiTxlQydSEIoSaGLKa2//gqzByIP1Y4jSA
         GtHQ==
X-Received: by 10.129.1.213 with SMTP id 204mr6899046ywb.48.1439338272226;
 Tue, 11 Aug 2015 17:11:12 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Tue, 11 Aug 2015 17:11:12 -0700 (PDT)
In-Reply-To: <1439326641-9447-5-git-send-email-jacob.e.keller@intel.com>
X-Google-Sender-Auth: 39M8B97fubuSM31tNoZ9CMG16NU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275748>

On Tue, Aug 11, 2015 at 4:57 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> Add new option "notes.<ref>.merge" option which specifies the merge
> strategy for merging into a given notes ref. This option enables
> selection of merge strategy for particular notes refs, rather than all
> notes ref merges, as user may not want cat_sort_uniq for all refs, but
> only some. Note that the <ref> is the local reference we are merging
> into, not the remote ref we merged from. The assumption is that users
> will mostly want to configure separate local ref merge strategies rather
> than strategies depending on which remote ref they merge from. Also,
> notes.<ref>.merge overrides the general behavior as it is more specific.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 488c2e8eec1b..2c283ebc309e 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1912,6 +1912,12 @@ notes.merge::
>         STRATEGIES" section of linkgit:git-notes[1] for more information
>         on each strategy.
>
> +notes.<localref>.merge::
> +       Which merge strategy to choose if the local ref for a notes merge
> +       matches <localref>, overriding "notes.merge". <localref> just be a

s/just/must/

> +       fully qualified refname. See "NOTES MERGE STRATEGIES" section in
> +       linkgit:git-notes[1] for more information on the available strategies.
> +
