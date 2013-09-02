From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 09/23] pack v4: commit object encoding
Date: Tue, 3 Sep 2013 03:48:28 +0700
Message-ID: <CACsJy8CnSyw2ae5BS87S8Hid51JVFB3gyLzX+5czwio+C=-VRQ@mail.gmail.com>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net> <1377577567-27655-10-git-send-email-nico@fluxnic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Sep 02 22:49:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGb3l-0008Hl-FV
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 22:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758916Ab3IBUs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 16:48:59 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:52848 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758900Ab3IBUs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 16:48:58 -0400
Received: by mail-oa0-f48.google.com with SMTP id o17so5766135oag.35
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 13:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nJuD1ht/6qlJM86DOgHTKzUhU3jf/D4pb/w7CPkQqEg=;
        b=awbxSOaDBs5S7sMI30u+CD2YeQq0K0YAJWJfj2b4NwztVfYvfe4haEF5L1WB0+Pl0x
         I66YV9hYqICFN5UainvCfPwKnlr5MdP1B5MRNT7jJwpAOu590X9Li5iSbBoMR6FlvEqC
         d2YSpMIucl4j3rsYdnvHo38WlgqhyM1un12BTH9B7qW1vBl9d2NXIU30ybFLeXXmgfdq
         yJn9o0Wj3DGjde+R9LR3YLMm7sJVaWBFKtkCHPannQIphS5gNZmIEWb+XbQnjFUn5tyN
         29PoOdEjrmDKYGrXH1PSY8AWq+rgOvDmiZ1CShpqFRkzpqgFF52p03j/vL1QGSRVeXe/
         88vw==
X-Received: by 10.60.145.241 with SMTP id sx17mr2590705oeb.57.1378154938151;
 Mon, 02 Sep 2013 13:48:58 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Mon, 2 Sep 2013 13:48:28 -0700 (PDT)
In-Reply-To: <1377577567-27655-10-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233658>

On Tue, Aug 27, 2013 at 11:25 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> This goes as follows:
>
> - Tree reference: either variable length encoding of the index
>   into the SHA1 table or the literal SHA1 prefixed by 0 (see
>   add_sha1_ref()).
>
> - Parent count: variable length encoding of the number of parents.
>   This is normally going to occupy a single byte but doesn't have to.
>
> - List of parent references: a list of add_sha1_ref() encoded references,
>   or nothing if the parent count was zero.

With .pack v3 it's impossible to create delta cycles (3b910d0 add
tests for indexing packs with delta cycles - 2013-08-23) but it is
possible with .pack v4 (and therefore at least index-pack needs to
detect and reject them), correct? Some malicious user can create
commit A with parent ref 1, then make the SHA-1 table so that ref 1 is
A. The same with the new tree representation.
-- 
Duy
