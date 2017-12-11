Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3E411F404
	for <e@80x24.org>; Mon, 11 Dec 2017 17:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbdLKRXn convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 11 Dec 2017 12:23:43 -0500
Received: from elephants.elehost.com ([216.66.27.132]:32611 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbdLKRXm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 12:23:42 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id vBBHNeng050760
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 11 Dec 2017 12:23:40 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'Marc-Andr=C3=A9_Lureau'?=" <marcandre.lureau@gmail.com>,
        "'Git'" <git@vger.kernel.org>
References: <CAJ+F1CJB+fOJmYpDQtjn1kLa-wk=oUeQGjO7q=N2igYhVG0tiQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CJB+fOJmYpDQtjn1kLa-wk=oUeQGjO7q=N2igYhVG0tiQ@mail.gmail.com>
Subject: RE: Shared clone from worktree directory
Date:   Mon, 11 Dec 2017 12:23:35 -0500
Message-ID: <000801d372a4$c9844c10$5c8ce430$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH4O0DkGPHsTv+8vlUKr2Qx0KWO76L00WHQ
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 11, 2017 12:02 PM, Marc-André Lureau wrote:
>For better, or worse, I encountered a script doing a git clone --shared from the working directory. However, if clone --shared is run from a worktree, it fails with cryptic errors.
>elmarco@boraha:/tmp/test/wt (wt)$ git worktree list
>/tmp/test     4ae16a0 [master]
>/tmp/test/wt  4ae16a0 [wt]
>elmarco@boraha:/tmp/test/wt (wt)$ git clone --shared  . clone-dir Cloning into 'clone-dir'...
>done.
>error: object directory /tmp/test/.git/worktrees/wt/objects does not exist; check .git/objects/info/alternates.
>fatal: update_ref failed for ref 'HEAD': cannot update ref
>'refs/heads/wt': trying to write ref 'refs/heads/wt' with nonexistent object 4ae16a066ee088d40dbefeaaae7b5578d68b4b51
>fatal: The remote end hung up unexpectedly
>Is this a bug? If not, a nicer error message would be welcome, as well as man page note.

"The add worktree documentation states:
    Create <path> and checkout <branch> into it. The new working directory is linked to the ***current repository***, sharing everything except working directory specific files such as HEAD, index, etc. - may also be specified as <branch>; it is synonymous with @{-1}."

So I'm going to assume that clone from a worktree is not supported. This sounds like a check is needed to prevent the operation from starting up in the first place, or changing the semantics to allow it. The error message, while cryptic, seems actually descriptive because the HEAD would not be available in a worktree as it is not propagated from the current repository.

If the idea is to support an add worktree from a worktree, I would suggest that a new branch go back to the main repository as normal, rather than being added to the worktree. I personally get a headache thinking about the prospect of having layers of worktrees.

Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately UNIX(421664400)/NonStop(211288444200000000) 
-- In my real life, I talk too much.



