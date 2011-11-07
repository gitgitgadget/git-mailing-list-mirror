From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 3/3] grep: get rid of useless x < 0 comparison on an enum member
Date: Mon, 7 Nov 2011 20:06:05 +0100
Message-ID: <CACBZZX7dipuDjCbb6oaLGHGYN-frgmRuLiDAebqs-LpQrJ=r2A@mail.gmail.com>
References: <1320581184-4557-1-git-send-email-avarab@gmail.com>
 <1320581184-4557-4-git-send-email-avarab@gmail.com> <m2pqh5nvic.fsf@igel.home>
 <CACBZZX6CRm1W5i43=LeXPJFdcWFgVTkD8cGntHoKsPoWGx_hNg@mail.gmail.com>
 <m3pqh4krer.fsf@hase.home> <20111107163823.GB27055@sigill.intra.peff.net>
 <m2k47b4wqi.fsf@igel.home> <20111107183402.GA5118@sigill.intra.peff.net> <20111107185536.GA5450@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jim Meyering <jim@meyering.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 07 20:06:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNUWf-0002hu-SJ
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 20:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664Ab1KGTG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 14:06:29 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63168 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab1KGTG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 14:06:28 -0500
Received: by bke11 with SMTP id 11so3906650bke.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 11:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Oe17VG1dlQPu+6FthSFA0I2t/RmWMGWvKBTaanXjSPI=;
        b=Ky4/aVkySeR//R3K2X2lHntaq0mTKj1Ve59EtzKtqYB/RAXihF+dzOnlD/6Xthnv6x
         YalCwYnx10mxaaikep1/IgVb+k4WOuUgFf+6j2M3tyTj86aY1zcyY4eMAnMUXzWdw/1c
         H/XcPN3E9WXzgwe6/0iC+SY/2Yj8TX9o9d7PY=
Received: by 10.204.154.7 with SMTP id m7mr4786865bkw.71.1320692787148; Mon,
 07 Nov 2011 11:06:27 -0800 (PST)
Received: by 10.204.118.67 with HTTP; Mon, 7 Nov 2011 11:06:05 -0800 (PST)
In-Reply-To: <20111107185536.GA5450@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185015>

On Mon, Nov 7, 2011 at 19:55, Jeff King <peff@peff.net> wrote:

> I do still question the value of the check at all, though, given that
> static analysis can find those bugs.

Agreed, which is why I submitted this patch.

Also if this is the sort of thing we'd like to guard against we should
be discussing it more generally. We have a bunch of occurances where
we'd probably break down if someone manually assigned -1 to an enum
variable:

    $ git grep -E -A1 'enum.*\{' | grep -B1 '=.*0' | grep enum
    builtin/branch.c:enum color_branch {
    builtin/branch.c:static enum merge_filter {
    builtin/fetch-pack.c:enum ack_type {
    builtin/fetch.c:enum {
    builtin/grep.c: enum {
    builtin/mv.c:   enum update_mode { BOTH = 0, WORKING_DIRECTORY,
INDEX } *modes;
    builtin/remote.c:enum {
    builtin/remote.c:       enum {
    cache.h:enum rebase_setup_type {
    cache.h:enum push_default_type {
    cache.h:enum object_creation_mode {
    cache.h:enum sharedrepo {
    cache.h:enum date_mode {
    cache.h:        enum {
    convert.h:enum safe_crlf {
    convert.h:enum auto_crlf {
    diff.h:enum diff_words_type {
    diff.h:enum color_diff {
    dir.c:enum exist_status {
    dir.h:  enum {
    grep.h:enum grep_header_field {
    http-push.c:enum dav_header_flag {
    imap-send.c:enum CAPABILITY {
    log-tree.c:enum decoration_type {
    merge-recursive.c:enum rename_type {
    merge-recursive.h:      enum {
    notes-merge.h:  enum {
    remote.h:enum match_refs_flags {
    rerere.c:       enum {
    unpack-trees.h:enum unpack_trees_error_types {
    wt-status.h:enum color_wt_status {
