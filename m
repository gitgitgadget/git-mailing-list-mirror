From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH v3 7/8] update-ref: support multiple simultaneous updates
Date: Mon, 02 Sep 2013 14:37:46 -0400
Message-ID: <5224DAFA.9000807@kitware.com>
References: <cover.1377885441.git.brad.king@kitware.com> <cover.1378142795.git.brad.king@kitware.com> <93efe58835dc2e569fe1e398a4cba5ec4d4b3771.1378142796.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 02 20:39:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGZ2K-0004pv-Vc
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 20:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758849Ab3IBSjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 14:39:37 -0400
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:54989 "HELO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758818Ab3IBSjg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Sep 2013 14:39:36 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]) (using TLSv1) by na3sys009aob120.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUiTbZ/E6J8cd2zXJ3TBklgPCqksGwVtl@postini.com; Mon, 02 Sep 2013 11:39:36 PDT
Received: by mail-ob0-f178.google.com with SMTP id ef5so4804921obb.23
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 11:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=gd86r5Rew2CVOBmIX4gD/kTrDQ5ShyQtCuDkaGlakBk=;
        b=GoSvc79s2bbLgWxN+SKHuxmhhy34+z5cLnGvIw61nqPuR98gDsClQbaQrAjFECqGt2
         xqAD2kjTzrtUS3S39QYQTnf31CZYOdo0RbnUcN+weyPwAZLu2ZfnxqgyPAHORwVBaXx6
         ordu4xUiuA3Jt3wyd4+dLbBOHdNDcF+EK4BzT29rHoHypnjwc1yP63KovZ1IRYTyqvyY
         GPPuh9mGmT0RZC2RFx9D0woIcg8XlF0pOtOGis/9k1VeQLk/klYSeDLsg9G44RqUn9Dy
         hrTpZZsNnaNxrSFqR7JpppOA+MQk1Qmtzh/uJo65pFAYbe+gzLEIkKnFnjcSt1/7hErg
         ssNA==
X-Gm-Message-State: ALoCoQlmL4dh2fJaLkVxOB8Jprh+0VFN3tdukLTMzztbM8rC9LrPAF9yTBFMH2/FHNdo3vQ4mEmZQCis2nurRYlCuiG+/Uf0jKXCBpItYlz6gfx9mQ6Wi6pmwlrj5PGEIoU/iCIYoAqy2pi/vDuGTLPLl5sshQUBlw==
X-Received: by 10.182.143.5 with SMTP id sa5mr17759093obb.80.1378147175375;
        Mon, 02 Sep 2013 11:39:35 -0700 (PDT)
X-Received: by 10.182.143.5 with SMTP id sa5mr17759090obb.80.1378147175285;
        Mon, 02 Sep 2013 11:39:35 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id uz16sm14251417obc.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 02 Sep 2013 11:39:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <93efe58835dc2e569fe1e398a4cba5ec4d4b3771.1378142796.git.brad.king@kitware.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233653>

On 09/02/2013 01:48 PM, Brad King wrote:
> +	/* Parse the argument: */
> +	strbuf_reset(arg);
> +	if (*next == '"') {
> +		if (unquote_c_style(arg, next, &next))
> +			die("badly quoted argument: %s", next);
> +		return next;
> +	}
> +	while (*next && !isspace(*next))
> +		strbuf_addch(arg, *next++);
> +	return next;

This quoting proposal was written in response to $gmane/233479:

On 08/30/2013 06:51 PM, Junio C Hamano wrote:
> When we need to deal with arbitrary strings (like pathnames), other
> parts of the system usually give the user two interfaces, --stdin
> with and without -z, and the strings are C-quoted when run without
> the -z option, and terminated with NUL when run with the -z option.

1. Do we want to allow arbitrary non-space characters in unquoted
arguments (while loop above) or reserve some syntax for future use?

2. Thinking about how the -z variation might work, I ran:

$ git grep '\[0\] == '"'"'"' -- '*.c'
builtin/check-attr.c:           if (line_termination && buf.buf[0] == '"') {
builtin/check-ignore.c:         if (line_termination && buf.buf[0] == '"') {
builtin/checkout-index.c:                       if (line_termination && buf.buf[0] == '"') {
builtin/hash-object.c:          if (buf.buf[0] == '"') {
builtin/mktree.c:       if (line_termination && path[0] == '"') {
builtin/update-index.c:         if (line_termination && path_name[0] == '"') {
builtin/update-index.c:                 if (line_termination && buf.buf[0] == '"') {

All of these support quoting only in the non-z mode (the hash-object.c
line follows a getline using hard-coded '\n').  However, they are
all in cases looking for one value on a line or at the end of a line
so their -z option allows NUL-terminated lines containing LF.

What distinguishes the "update-ref --stdin" case is that we want to
represent multiple arguments on one line, each allowing arbitrary
characters or an empty string.  From a brief search a couple places
I found that do something related are:

* apply: Read multiple paths from a diff header, using unquote_c_style
  for quoted paths and separated by spaces.  There is no -z input mode.

* config: Output keyword=value\n becomes keyword\nvalue\0 in -z mode.
  This works because the first piece (keyword) cannot have a LF
  and there is at most one value so all LFs belong to it.

* quote.c: sq_dequote_to_argv handles single quotes like a shell
  would but allows only one space between arguments.  No -z mode.
  This is similar to my v2 proposal.

If we use unquote_c_style and spaces to divide LF-terminated lines,
how shall we divide arguments on NUL-terminated lines?

Thanks,
-Brad
