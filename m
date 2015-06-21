From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: RE: [PATCH v6 17/19] fsck: Introduce `git fsck --quick`
Date: Sun, 21 Jun 2015 16:40:35 +0200
Organization: gmx
Message-ID: <a9e5e7c2580ed138d3fc9576799fe1df@www.dscho.org>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
 <5f1c4c16027b00ef80490d67bec5e948481153ec.1434720655.git.johannes.schindelin@gmx.de>
 <xmqq1th77829.fsf@gitster.dls.corp.google.com>
 <95e42f21de69ab5299c03ce6ad107037@www.dscho.org>
 <xmqqoakb5sk2.fsf@gitster.dls.corp.google.com>
 <558643CA.6000303@alum.mit.edu>
 <000201d0abe0$7f3ccf20$7db66d60$@nexbridge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: 'Michael Haggerty' <mhagger@alum.mit.edu>,
	'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
	peff@peff.net
To: "Randall S. Becker" <rsbecker@nexbridge.com>
X-From: git-owner@vger.kernel.org Sun Jun 21 16:41:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6gQo-0000T3-9U
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 16:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486AbbFUOlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 10:41:06 -0400
Received: from mout.gmx.net ([212.227.15.18]:59793 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821AbbFUOlD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 10:41:03 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MfVYB-1ZUY8c0c39-00P5NI; Sun, 21 Jun 2015 16:40:37
 +0200
In-Reply-To: <000201d0abe0$7f3ccf20$7db66d60$@nexbridge.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:bzSI/kYc3F3SjgNnz4q6pNlpjbhuxY/5GXAKWVLSNLPV4a2xGYv
 ipFhRESlVkTU/6nENi0rpCO3jRPAnvTIIrS49hT3NgGdJvPx/J7HbjczIgEYH9PoWqe6/Rm
 faHKmimbXaT+VuE6ZrFlJpbTJCcSHSYAwQtsp0pLghpCPKPWKZbQapzg5x6FmaViICbbjXg
 3/4lNV7acBPkUBIclEHtw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272269>

Hi Randall,

On 2015-06-21 07:09, Randall S. Becker wrote:
> On June 21, 2015 12:56 AM, Michael Haggerty wrote:
>
>> As for thinking of a shorter name for the option: assuming the blob integrity
>> checks can be turned on and off independently as described above, then I think
>> it is reasonable to *also* add a `--quick` option defined as
>>
>> --quick: Skip some expensive checks, dramatically reducing the
>>     runtime of `git fsck`. Currently this is equivalent to
>>     `--no-check-blob-integrity`.
>>
>> In the future if we invent other expensive checks we might also add them to the
>> list of things that are skipped by `--quick`.
> 
> Synonym suggestions: --links or --relations
> I was going to include --refs but that may be ambiguous. Links also has
> meaning so it's probably out and --hitch may just be silly and needlessly
> introducing a new term.

I appreciate your input, but I think in this case, "links" and "relations" would just add new terminology, and I would like to keep using existing terminology as much as possible (because we already have a confusingly large glossary). I also see "link" as a problematic term because it resembles "gitlink" -- which means something entirely different.

My favorite is still `--quick` because in contrast to Junio, to me it *has* a connotation of "less thoroughly". "Get rich quick" just does not mean "Earn a lot of money by doing a thorough job, just faster than you usually would".

If Junio insists, I will of course rename it to `--skip-blobs` because that is really what we do. However, it has been my experience over and over again that letting implementation details bleed through to the user interface always comes back to haunt you[*1*]. In this case, the purpose of the option really just was to cut a few corners to run `git fsck` more quickly. The fact that the corner I cut here is to skip unpacking of the blobs just happens to be the implementation detail.

So, Junio, what is it: keep `--quick` and clarify in the documentation that we cut corners (and which corners), or rename it to `--skip-blobs`? Your call.

Ciao,
Dscho

Footnote *1*: You would not believe how often I had to apologize for renaming the `edit-patch-series` script to `interactive rebase`. You see, technically it is correct to call it an interactive rebase: it really is that, from a purely technical, soul-less point of view. From the users' point of view, however, the name `edit-patch-series` would relate exactly what the command is *about*, as opposed to *how* it works. To most users, calling it "rebase -i" is as understandable as "sympodial fasciculation and regrafting of disconnate vernates" (and don't ask me what that even means).
