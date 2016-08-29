Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6B2D1FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 12:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932754AbcH2MGe (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 08:06:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:64133 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932628AbcH2MGe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 08:06:34 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LkxLZ-1b4S9J0wAn-00amNE; Mon, 29 Aug 2016 14:06:28
 +0200
Date:   Mon, 29 Aug 2016 14:06:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 07/15] sequencer: lib'ify read_populate_opts()
In-Reply-To: <xmqq1t1big38.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608291405080.129229@virtualbox>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <85a8ec8273994c599402c380abd383ad2f539777.1471968378.git.johannes.schindelin@gmx.de> <xmqq1t1big38.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ye7G4Gv0uA959MBFd75G5/hcWMjd5HCn3GFep6DGdvGAi3BXqbu
 qh2R4v83RXquMGZPRxrV+ZA00VvE827VLgiG1VcbFhh0jb5GoXSephjeRzws6DKqVtRiDra
 xlLvu5SM0AqqyUpJiNKGDwoa3yF+mM5DoEDuiCCRaPzIh8ZMLhPuaAphX9vhSLCK6EkocM2
 LP0Ns6izvjv5hK5bwuFhg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NxG9WyyScYU=:QLPvXG9Swj7YMDMc0mG/NY
 merzHz1eVWuJSCC6qCK0eqvqTMBEZOBdwNf1FnVTXrjPZOMCtPb46vjVuQ76KEiAP5PKo9qg5
 +IbJOdNeGSTFw/EEU6QgtNASVmz80kQg6vEPKSfPx2DOFyF82JAAiG8scANRXuh0uHTQ6hu13
 t++dOCKpDS9BFFNLNkcINBAW1e+C5o3+/Z8gKIMGA5RKGojK6zDpazyvpiRWTDx2NfcivNiRn
 jE7a4QR0MQP4UURNkcR96kVteXeBtpcbvBRuYgr6Cy6HHkDOvcc+Wy6EzSbRxvP2fVgHCVgCI
 mb/Fr6qJRHKsoFr+o3KFFHnAMeYMPLU8q+alfXgZ7Tb6ZPrU907RfrRGQhyCn5OOFpDSGerma
 Xrhp8vmgcfZqTGPIEkzy8lGlE5MpxzhwngYE1OzqlDG8FQWCEyDdE2YgrKtP1/qopI3Uo9dt1
 eJ+mGoAxz04poA/J2KU9zxwk2Jsy15MI3bnOWqEeVKx8RCHpHqjY0Vp0LCCJ3Vr3vkJq1Uv+v
 anhk+SPlpFg05eNycInIssTeGSbyTtT+IzeFn/s8fMC/yq8yB1Zsv05EaHxOLwT9vyeTQ4rf5
 SXllWarQi9GB+Iyj7w7xzpyYOgsCDAOUkxqjFB3UaVvdc4VCGbKxb06zKfBpKY29uKq6Ofqoh
 kFh/ctiv8XEqxuod0Q4H7w7hGCKUGAJ7HZqDL325yUHw6JzWs9ooPBb+Ct6U0kzPhpOb/+zTb
 tIPTba73vyoRlchLlF+3y36sde5JCJfb2LLqpR2xmXGs1JvRqiMpQv95NllyC12qvt8Wz68hj
 J7s79xB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 26 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > -static void read_populate_opts(struct replay_opts **opts_ptr)
> > +static int read_populate_opts(struct replay_opts **opts)
> >  {
> >  	if (!file_exists(git_path_opts_file()))
> > -		return;
> > -	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), *opts_ptr) < 0)
> > -		die(_("Malformed options sheet: %s"), git_path_opts_file());
> > +		return 0;
> > +	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), *opts) < 0)
> > +		return error(_("Malformed options sheet: %s"),
> > +			git_path_opts_file());
> > +	return 0;
> 
> This may not be sufficient to avoid die(), unless we know that the
> file we are reading is syntactically sound.  git_config_from_file()
> will die in config.c::git_parse_source() when the config_source sets
> die_on_error, and it is set in config.c::do_config_from_file().
> 
> The source we are reading from is created when the sequencer
> machinery starts and is only written by save_opts() which is
> called by the sequencer machinery using git_config_set*() calls,
> so I think it is OK to assume that we won't hit errors that would
> cause git_config_from_file() to die, at least for now.

I amended the commit message.

Ciao,
Dscho
