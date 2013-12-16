From: Samuel Bronson <naesten@gmail.com>
Subject: Re: [RFC v3 3/3] diff: Add diff.orderfile configuration variable
Date: Mon, 16 Dec 2013 14:21:13 -0500
Message-ID: <CAJYzjmcxswLUw3wU6TO_s_vFXYM1mu4HCXZ=8ksWELxXCSt4cg@mail.gmail.com>
References: <1387059521-23616-1-git-send-email-naesten@gmail.com>
	<1387059521-23616-4-git-send-email-naesten@gmail.com>
	<xmqqfvpspqyj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 16 20:21:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsdjC-0000x0-9l
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 20:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897Ab3LPTVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 14:21:14 -0500
Received: from mail-oa0-f44.google.com ([209.85.219.44]:33198 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565Ab3LPTVN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 14:21:13 -0500
Received: by mail-oa0-f44.google.com with SMTP id m1so5547262oag.31
        for <git@vger.kernel.org>; Mon, 16 Dec 2013 11:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Kso7VCQlhzKDFRyr67W+SdBhvaRG3fW9ufRBKadLWsA=;
        b=LzTr7g2xBXgBgwIP0w+an22z7iDyFuQFzaNYL0Ijx8rn6/OFJVXxEMxqnDGxRNfU2I
         PQHG6Ab67NzUkEZE3p3bWR1TKeCr1jHhRh7XoutjirPVF9Gk3x3G2i4w4uGX/hhqo8Sp
         2cMQ5I0Ae81xn1AUryhpyEtp16bmBWAkP2M9MigTMX3BSvfjC9mnEhwtV/5aTM8MUC9d
         SiijQlUXeJQag3db/pktdO+Nas+Ouly398fjBJoFpwY5nkDI15QnMSfMgdyB2SqWW28j
         +TI63DGwdbMbZ+tGhKdwp/ha7cob9PFavMsR9ZQKqr5EQBPJpQmD74oN3+vZlBMX+sYH
         +hXg==
X-Received: by 10.60.44.239 with SMTP id h15mr12986601oem.22.1387221673150;
 Mon, 16 Dec 2013 11:21:13 -0800 (PST)
Received: by 10.182.135.3 with HTTP; Mon, 16 Dec 2013 11:21:13 -0800 (PST)
In-Reply-To: <xmqqfvpspqyj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239350>

On Mon, Dec 16, 2013 at 1:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Samuel Bronson <naesten@gmail.com> writes:

> Path-like parameters and values given by the end user should be
> relative to the directory where the end user is (i.e. both -O
> parameters in the above example name docs/orderfile).  All Git
> processes, even the ones that are capable of being run from a
> subdirectory, are supposed to first chdir to the top level of the
> working tree before doing anything else, and adjust the path-like
> things they get from the end user from the command line accordingly.
> By the time diffcore_order() to prepare_order() callchain is called,
> we certainly should have passed that chdir already, so the value of
> the option needs to be prepended with the "prefix" when parsed.
>
> The value specified for the diff.orderfile configuration can just be
> a path relative to the top level of the working tree, I think.

Oh, cool.  So I'll just change the git_config_string() call to use
git_config_pathname(), since the user might easily want to use ~
notation there, especially in a user-level setting ...
