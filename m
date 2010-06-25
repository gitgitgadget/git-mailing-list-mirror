From: Daniel Shahaf <d.s@daniel.shahaf.name>
Subject: Re: [WIP PATCH 1/7] Add skeleton RA svnclient
Date: Fri, 25 Jun 2010 14:30:57 +0300 (Jerusalem Daylight Time)
Message-ID: <alpine.561.2.00.1006251412170.2144@daniel2.local>
References: <1277310140-16891-1-git-send-email-artagnon@gmail.com>  <1277310140-16891-2-git-send-email-artagnon@gmail.com> <20100625001427.GA4683@burratino>  <alpine.561.2.00.1006251156180.2064@daniel2.local>
 <AANLkTimirObq-HBrB4rQdAprN8mfd92rfFKSegJKwMsc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1130515-17285-1277465462=:2144"
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 13:30:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OS778-0003Ah-KM
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 13:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754607Ab0FYLaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 07:30:14 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34803 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753622Ab0FYLaM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jun 2010 07:30:12 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9DD47107E98;
	Fri, 25 Jun 2010 07:30:01 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 25 Jun 2010 07:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=smtpout; bh=Y7vxC/wSJfWOvmlM/arsN0HSBQU=; b=Tk0GaparglSinPdpCt0ShGEeTCdMACn8tPSCIuf47VOfRUuc1QgC8R6a9sOnvNiCCnaYsb+0pA875sYlNkGToZuuuKRRX68LrKP9aWUM/uURMAwrpxsvWv/kBLqg9QGdNidejizpcVmyGZN1i/uscVCzpA33LZUf+FupAOMflKQ=
X-Sasl-enc: Oxkkj42vC+Xs0ociD8vKTr4mVbXDIGGU1DaotRklhHOoKTRAQr0bg/7kLS3Bbw 1277465401
Received: from daniel2.local (bzq-79-176-24-110.red.bezeqint.net [79.176.24.110])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 17CF84E2F0;
	Fri, 25 Jun 2010 07:29:59 -0400 (EDT)
In-Reply-To: <AANLkTimirObq-HBrB4rQdAprN8mfd92rfFKSegJKwMsc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149679>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1130515-17285-1277465462=:2144
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Ramkumar Ramachandra wrote on Fri, 25 Jun 2010 at 14:07 -0000:
> Daniel Shahaf wrote:
> > Jonathan Nieder wrote on Fri, 25 Jun 2010 at 03:14 -0000:
> >> What is a baton?
> >>
> >
> > The context object for a callback.
> >
> > You call:
> >
> >    some_function(your_callback_function, your_baton)
> >
> > which then calls:
> >
> >    your_callback_function(your_baton, other_arguments)
> 
> In general, I've found that batons are void * objects in which you can
> stuff anything you like and pass around from function to function:
> I've abused them quite heavily in my code by stuffing all kinds of
> things into them: see fb->eb->* in my current code for an example of
> this.
> 

We do that too sometimes:

% pwd
$trunk_wc/subversion/libsvn_client/
% grep -- "->eb->" *.c | head
commit_util.c:  return (*db->eb->real_editor->add_file)(path, db->real_baton,
commit_util.c:  return (*db->eb->real_editor->delete_entry)(path, revision,
commit_util.c:  return (*db->eb->real_editor->open_file)(path, db->real_baton,
commit_util.c:  return (*fb->eb->real_editor->close_file)(fb->real_baton,
commit_util.c:  return (*fb->eb->real_editor->change_file_prop)(fb->real_baton,
commit_util.c:  return (*fb->eb->real_editor->apply_textdelta)(fb->real_baton,
...


> >> [...]
> >> > +  void *wrapped_edit_baton;
> >> [...]
> >> > +  void *edit_baton;
> >> > +  void *wrapped_dir_baton;
> >> [...]
> >> > +  void *edit_baton;
> >> > +  void *wrapped_file_baton;
> >>
> >> Are these opaque types necessary?
> >>
> >
> > The convention in Subversion's code is to convert the void * to
> > a concrete_baton_t * only inside the callback.  If you wish to declare
> > these, e.g., as
> >
> >    debug_editor_baton_t *wrapped_baton;
> >
> > You can probably do that too.
> 
> The function prototypes in libsvn contain void * parameters
> corresponding to batons, so I'd have to typecast explicitly to avoid
> any warnings.

By the way, a common pitfall is to mis-treat the void *baton argument as
the wrong type of baton.  That is, code of the form

    f(void *baton) {
        foo_baton_t *fb = baton;
    }

instead of

    f(void *baton) {
        bar_baton_t *bb = baton;
    }

> I think Jonathan's also referring to the absence of the
> "struct" keyword everywhere, as that is against Git policy.
> Unfortunately, everything is typedef'ed in libsvn, and we cannot do
> much about that.
> 

Usually we do

    typedef struct svn_error_t svn_error_t;

so you can add the 'struct' back if you want.

> >> What does this do?  Is SVN_ERR for debugging?
> >
> > That's how we implement exception throwing in C.  SVN_ERR means "if this
> > returned a non-NULL svn_error_t *, then return that error to our
> > caller".
> >
> > The other pattern does
> >
> >    svn_error_t *err = svn_stream_printf();
> >
> > and then inspects err and err->apr_err to decide whether to ignore the
> > error or return it (possibly wrapped).
> 
> >> Where does the output go?
> >>
> >
> > SVN_ERR does not print anything.  It may return(), though.
> 
> Embarrassingly enough, write_indent does exactly what it says it does:
> It writes some spaces (or indent) to eb->out

To represent nesting.

> Note however, that even with all this error handling, the most common
> type of error I get by far is the segfault: I'll make an effort to
> document the pitfalls.
> 

Note there are several kinds of errors that can cause a segfault.
(@Ram, you've encountered some of them already, I know.)

> >> I take it these are callbacks?  Is there overview documentation for
> >> them somewhere?
> >>
> >
> > svn_delta_editor_t in
> > http://svn.apache.org/repos/asf/subversion/trunk/subversion/include/svn_delta.h
> 
> Yes, they are callbacks that are fired automatically by the editor. In
> svn_delta.h, look at struct svn_delta_editor_t (and the corresponding
> doxygen-style comments).
> 

The compiled doxygen docs are available on
<http://subversion.apache.org/docs/#api>.  Personally I always
just read the header file directly (with :set filetype=c.doxygen).
--1130515-17285-1277465462=:2144--
