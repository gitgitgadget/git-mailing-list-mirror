Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DAE51F404
	for <e@80x24.org>; Wed, 24 Jan 2018 20:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932251AbeAXUt6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 15:49:58 -0500
Received: from elephants.elehost.com ([216.66.27.132]:38126 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932072AbeAXUt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 15:49:57 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0OKnrCH023828
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 24 Jan 2018 15:49:53 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        <randall.s.becker@rogers.com>
Cc:     <git@vger.kernel.org>
References: <20180121234203.13764-1-randall.s.becker@rogers.com>        <20180121234203.13764-4-randall.s.becker@rogers.com> <xmqq1sifdmf3.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq1sifdmf3.fsf@gitster.mtv.corp.google.com>
Subject: RE: [PATCH v4 3/4] Bring NonStop platform definitions up to date in git-compat-util.h
Date:   Wed, 24 Jan 2018 15:49:46 -0500
Message-ID: <001601d39554$e19d24c0$a4d76e40$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQG+M0yL6q6MsDdNM8SZpgZC9eG5XQJYngodAcg/ICejjTuNcA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 24, 2018 3:36 PM, Junio C Hamano wrote:
> randall.s.becker@rogers.com writes:
> 
> > From: "Randall S. Becker" <rsbecker@nexbridge.com>
> >
> > Add correct FLOSS (NonStop platform emulation) definitions into
> > git-compat-util.h to allow correct emulation of non-platform
> > behaviour. Also added NSIG definition that is not explicitly supplied
> > in signal.h on platform.
> >
> > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> > ---
> >  git-compat-util.h | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/git-compat-util.h b/git-compat-util.h index
> > 68b2ad531..fb3ef0dcf 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -378,6 +378,21 @@ static inline char *git_find_last_dir_sep(const
> > char *path)  #define find_last_dir_sep git_find_last_dir_sep  #endif
> >
> > +#ifdef __TANDEM
> > +#if !defined(_THREAD_SUPPORT_FUNCTIONS) &&
> !defined(_PUT_MODEL_)
> > +/* #include <floss.h(floss_read,floss_write,floss_fsync,floss_fork)>
> > +*/
> > +/* #include <floss.h(floss_fork)> */
> > +#endif
> 
> The above adds a conditional no-op?  That's confusing...

We are trying to make PUT work with git on NonStop. I can't tell you how
much of a pain it is. This is a placeholder for others (outside our group)
to know where to muck. I can remove it if you don't want it there.
 
> > +#include <floss.h(floss_execl,floss_execlp,floss_execv,floss_execvp)>
> > +#include <floss.h(floss_getpwuid)>
> > +#if ! defined NSIG
> > +/* NonStop NSE and NSX do not provide NSIG. SIGGUARDIAN(99) is the
> highest
> > +   known, by detective work using kill -l as a list is all signals
> > +   instead of signal.h where it should be. */ # define NSIG 100
> > +#endif #endif
> > +
> >  #if defined(__HP_cc) && (__HP_cc >= 61000)  #define NORETURN
> > __attribute__((noreturn))  #define NORETURN_PTR

