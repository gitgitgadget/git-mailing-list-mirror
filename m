From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] wt-status: Show ignored files in untracked dirs
Date: Thu, 27 Dec 2012 11:19:20 -0500
Message-ID: <20121227161920.GA28162@sigill.intra.peff.net>
References: <1356516985-31068-1-git-send-email-apelisse@gmail.com>
 <1356528674-2730-1-git-send-email-apelisse@gmail.com>
 <7vip7omd8c.fsf@alter.siamese.dyndns.org>
 <20121227034859.GA20817@sigill.intra.peff.net>
 <7va9t0m69o.fsf@alter.siamese.dyndns.org>
 <CALWbr2wFg_9oDoZ_BUQwAzVV+UJSqBQRrMYmt6fv=fo02RL7Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 27 17:19:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToGBS-00048e-7s
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 17:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133Ab2L0QTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2012 11:19:32 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37138 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753019Ab2L0QTa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 11:19:30 -0500
Received: (qmail 13141 invoked by uid 107); 27 Dec 2012 16:20:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Dec 2012 11:20:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Dec 2012 11:19:20 -0500
Content-Disposition: inline
In-Reply-To: <CALWbr2wFg_9oDoZ_BUQwAzVV+UJSqBQRrMYmt6fv=fo02RL7Zg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212203>

On Thu, Dec 27, 2012 at 05:14:54PM +0100, Antoine Pelisse wrote:

> > Nicely analysed.  Perhaps we would want new test pieces to define
> > the behaviour we want to see first?
> 
> I think we should.
> 
> I also thought about the use case of "committed" and ignored directory
> which is also broken to me (point 3 in the table below).

By "committed", I assume you meat that you have "dirA/unco" as an
untracked file, and "dirA/committed" as a file in the index?

> Anyway I tried to make a table to sum-up/discuss the list of behaviors
> we would like to see/test, taking Jeff mail into account.
> (warning: that requires fixed width font)
> 
> |----------------------+---------------------+---------------------------|
> | Output               | A. status --ignored | B. status --ignored -uall |
> |                      |                     | (or with potential        |
> |                      |                     | --ignored=all)            |
> |----------------------+---------------------+---------------------------|
> | 1. Untracked dirU    | Current:            | Current:                  |
> | with ignored unco.ig | Empty               | Empty                     |
> | in it                |                     |                           |
> |                      | Expected:           | Expected:                 |
> |                      | !!dirU/             | !!dirU/unco.ig            |
> |----------------------+---------------------+---------------------------|
> | 2. Untracked and     | Current (OK):       | Current:                  |
> | ignored dirU with    | !!dirU/             | !!dirU/                   |
> | file in it           |                     |                           |
> |                      |                     | Expected:                 |
> |                      |                     | !!dirU/unco               |
> |----------------------+---------------------+---------------------------|
> | 3. "Committed" dirA  | Current:            | Current:                  |
> | yet ignored          | Empty               | Empty                     |
> | with uncommitted     |                     |                           |
> | file in it           | Expected:           | Expected:                 |
> |                      | dirA/               | dirA/unco                 |
> |----------------------+---------------------+---------------------------|

Thanks for putting this together. I agree with the expected output in
each case, and I think this covers the cases we have seen (case 1 is
Michael's original report, case 2 is what I wrote in my mail, and case 3
is the one you just came up with). I can't think offhand of any others.

-Peff
