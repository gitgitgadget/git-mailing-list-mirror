From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [PATCH 2/3] Teach read_tree_recursive() how to traverse into 
	submodules
Date: Sun, 18 Jan 2009 23:46:00 +0100
Message-ID: <8c5c35580901181446n3c36a345m5d8e78764a85c123@mail.gmail.com>
References: <1232275999-14852-1-git-send-email-hjemli@gmail.com>
	 <1232275999-14852-2-git-send-email-hjemli@gmail.com>
	 <1232275999-14852-3-git-send-email-hjemli@gmail.com>
	 <alpine.DEB.1.00.0901181635290.3586@pacific.mpi-cbg.de>
	 <8c5c35580901180945u17a69140vff2736765ee6073@mail.gmail.com>
	 <alpine.DEB.1.00.0901181929220.3586@pacific.mpi-cbg.de>
	 <8c5c35580901181145x2e14fe0fq4ab0e94c13bad38a@mail.gmail.com>
	 <alpine.DEB.1.00.0901182201140.3586@pacific.mpi-cbg.de>
	 <8c5c35580901181331v5e54f82fxc6a042962ff1cd06@mail.gmail.com>
	 <alpine.DEB.1.00.0901182244310.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 23:47:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOgQT-0007hA-Vs
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 23:47:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbZARWqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 17:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752543AbZARWqD
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 17:46:03 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:36266 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbZARWqB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 17:46:01 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1341254wah.21
        for <git@vger.kernel.org>; Sun, 18 Jan 2009 14:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DH/jkXC/SgSejdDoZ7dR4lc7OxQytWhV5TjZ3PjLSWo=;
        b=XRKBYDmn27doTVBAVjjm1+C+DavM3DPkCscpjnaVQ4GoDir11ETxB9KEn9hriy/ClM
         tIfxpGZEOJHWoxmTL0dvOcdxu0Xx7Jfd1ECU6TWnlwMDkLuTImqsDedA5GQtMdpaU/l0
         B+enzbEuTGcUUE1LnTPynjApbgmzL17FPlzyw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=G+QixjCJFWLDt0R7rE3tEKHgXb44oOG0h4s3l+Dz7LSFM+uCiMz8nh7NVBvbIdISoy
         x3GTCBlh/h+3Dt1Ey47iZ2j77I3ZcmjBTtOZBOcEs0T7jmRMlWq+NjPLnSoaqLNpUs/l
         dnA5ro/tfegK+ZDtzsQp7012B3HGVhu2rYo8I=
Received: by 10.115.94.1 with SMTP id w1mr3560765wal.177.1232318760687; Sun, 
	18 Jan 2009 14:46:00 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901182244310.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106292>

On Sun, Jan 18, 2009 at 22:55, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 18 Jan 2009, Lars Hjemli wrote:
>
>> So, would you rather have something like `git archive --submodules=foo
>> --submodules=bar HEAD` to explicitly tell which submodule paths to
>> include in the archive when executed in a bare repo?
>
> That does not quite say what you tried to do, does it?  You tried to
> traverse submodules whose commit can be found in the object database.
>
> Setting aside the fact that we usually try to avoid accessing unreachable
> objects, which your handling does not do, our "git submodule" does not do
> that either; it only handles submodules that are checked out.
>
> Now, this behavior might be wanted, in bare as well as in non-bare
> repositories, but I think it should be triggered by an option, such as
> "--submodules=look-in-superprojects-odb".

Sorry, but if your concern is whether to traverse a submodule in a
bare repo when the submodule isn't checked out (yeah, contradiction in
terms), I just don't see the point.

For non-bare repositories the policy has always been to ignore
submodules which isn't checked out, but for bare repositories there is
no obvious way (for me, at least) to apply the same policy. Therefore
I proposed to traverse all submodules where the linked commit is
reachable, but as you pointed out this would be wrong for non-bare
repositories.

I then modified my proposal to include a check on
is_bare_repository(): If we're not in a bare repository,
read_tree_recursive() is only allowed to recurse into checked out
submodules. But if we're in a bare repository, read_tree_recursive()
is allowed to recurse into any submodule with a reachable commit.

Now then, if `--submodules=look-in-superprojects-odb` should be
required to trigger the latter behavior, running `git archive
--submodules HEAD` in a bare repository would always produce identical
output as `git archive HEAD` and this is why I don't understand the
gain of 'look-in-superprojects-odb' (I thought you wanted to limit
which of the reachable submodules to recurse into).

--
larsh
