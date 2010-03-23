From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Tue, 23 Mar 2010 14:01:04 +0800
Message-ID: <41f08ee11003222301y569a5972q3c67d10c77abe27a@mail.gmail.com>
References: <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
	 <41f08ee11003202316w2fddc5f4jebda47f325451577@mail.gmail.com>
	 <4BA61CF9.7040104@gmail.com>
	 <41f08ee11003212048q1950eb3s95f1caf7ba640874@mail.gmail.com>
	 <7vfx3tvv9y.fsf@alter.siamese.dyndns.org>
	 <41f08ee11003212134s586aa71cs23255d02f38d53d1@mail.gmail.com>
	 <7vhbo8syyf.fsf@alter.siamese.dyndns.org>
	 <41f08ee11003220031p6fda651eycff2641df10864da@mail.gmail.com>
	 <7v7hp4n6qn.fsf@alter.siamese.dyndns.org>
	 <20100322081003.GA26535@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, gitzilla@gmail.com,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 07:01:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtxB5-0004uL-Uj
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 07:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315Ab0CWGBI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 02:01:08 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:36257 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab0CWGBF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Mar 2010 02:01:05 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1444772qwh.37
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 23:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Z27Kqu+6fVwXvNvuFNgVoFT6Z4oI+HkG3+dFUgwsxZM=;
        b=KVvQPtuwKx+wjJlcQaYp70d/w26x1YrC1vr0+HVb8NYYbjzx5YxTx+w4k0M+rc/Dc5
         S0WhS64TwQy+/kxMIIcK8/NqB3mRfO9dz76De0999nOeIavJcA9UAcU5jA2NdhNBZqPa
         q8W1mndwsufJ9PZDKLbQ39hCyppAvQuiiMPUc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TkcUbV4sTv0gqUBX9TeH8+jDseG+0TU4nsdjHNCyRpHYGuTUL18aGIHFS6f8SoMLnS
         Re4RmV7vJBq99Ys6gaqrmnOSVyJc6Ce1uM3HY9SAsAOcyGWXKUcRjmoMB0pM7budJaEY
         NXrKHHou1oVva9fP1eAogT+XISHHXmoVZm7Vk=
Received: by 10.229.221.78 with SMTP id ib14mr274215qcb.28.1269324064593; Mon, 
	22 Mar 2010 23:01:04 -0700 (PDT)
In-Reply-To: <20100322081003.GA26535@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142988>

Hi,
> Hmm, I can imagine some (mutually inconsistent) heuristics:
>
> =A0- Suppose in the blamed commit a single isolated line changed. =A0=
Then
> =A0 it is clear where to look next.
>
> =A0- If the mystery code is at the beginning of the file (resp.
> =A0 beginning of a diff -C0 hunk), maybe it was based on the line at =
the
> =A0 same position within the previous commit.
>
> =A0- Take the line with the lowest Levenshtein distance from the myst=
ery
> =A0 code.
>
> =A0- Expect certain common patterns of change: substituted words,
> =A0 whitespace changes, added arguments for a function, things like t=
hat.
>
> That said, I still don=92t have a clear picture of a basic strategy.

I can't understand fully about your above strategy. I think we can
category the code change into two cases:
1. The diff looks like:

@@ -1008,29 +1000,29 @@ int cmd_format_patch(int argc, const char
**argv, const char *prefix)
                add_signoff =3D xmemdupz(committer, endpos - committer =
+ 1);
        }

-       for (i =3D 0; i < extra_hdr_nr; i++) {
-               strbuf_addstr(&buf, extra_hdr[i]);
+       for (i =3D 0; i < extra_hdr.nr; i++) {
+               strbuf_addstr(&buf, extra_hdr.items[i].string);
                strbuf_addch(&buf, '\n');
        }


ie: there is both deletion and addition in a change. And this means we
modify some lines of the code. So, what we do will be tracing the two
'minus' lines and then find another diff. Start trace from that diff
recursively.
Yes, the new added code may also be moved or copied from other place.
But, I think here, we should focus on the lines before this changeset.

2. The diff looks like:

@@ -879,9 +885,12 @@ int cmd_grep(int argc, const char **argv, const
char *prefix)
        opt.regflags =3D REG_NEWLINE;
        opt.max_depth =3D -1;

+       strcpy(opt.color_context, "");
        strcpy(opt.color_filename, "");
+       strcpy(opt.color_function, "");
        strcpy(opt.color_lineno, "");
        strcpy(opt.color_match, GIT_COLOR_BOLD_RED);

This means, the code here is added from scratch. Here, I think we have
three options.
1. Find if the new code is moved here from other place.
2. Find if the new code is copied from other place.
3. We find the end of the history, so stop here.

The problems remain how do we find the copied/moved code. The new
added code may be copied/moved from multiple place with little
changes.

I hope I understand the requirement of the line-level browser, could
you please point it out if I have made some mistake?

Regards!
Bo
