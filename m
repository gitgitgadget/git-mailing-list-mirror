Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B80B81FF32
	for <e@80x24.org>; Fri, 20 Oct 2017 17:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753285AbdJTRTV (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 13:19:21 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:52071 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753031AbdJTRTU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 13:19:20 -0400
Received: by mail-pf0-f179.google.com with SMTP id n14so11939372pfh.8
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 10:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gZHhI+0dqDPrdnQx4pE3j+LJlZT6TpS9jfSxkp04FZs=;
        b=SfElimMg/d45Yz7A1DuL+Y6SPAq5BLpOIoCbxKweVMPC0kV5iDCe5Qw73XXSxxn/iy
         XwROHfs10pbkfjaJAjMx+ZnEC3igVnaT5vY4G1whatXwVHT9LiMJJF4JP4tX1+jSSarp
         ejeIRA+IclgjRYIsMrNJL+LPK+Vvg89gM40vn980ZgLO7nGaDkX5/oi40SWiFJbGORRm
         uaotS0lgH+wTcbl3GU5EirUkLD4MzsOJY5wu8A4nOK2k+46E+22Y3zKlm9Z/SP+9Afnh
         R+PhJZ6JZtkVb4j8FxoWbqMLXJQow0hJMKJcr5Jqrib8E9RZzAqNuDflh00iMEDg/gYu
         zF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gZHhI+0dqDPrdnQx4pE3j+LJlZT6TpS9jfSxkp04FZs=;
        b=HkwSC0HS9c0eVu20Se9vBccet7ZJMQqh7hv7utZdkyR9UArocWj8ANyYhLpknPNmq2
         zbID6C5OrwFLJXi5nt8XyCczxdxikQftHDYdeDgBn94sZslK39e8kMoCRldoybirnd+M
         ptye1pT2STgAq/Rt8OJktysE37VSLECDL5ZtcV4w3urGrScs/xkn9NrrOgw0xV85mCS3
         98hi9dSTQ9f2E2kuVCMKuEgJR2D1vk/DGg8wk6PZJJoW5b18GN2ZKt9Igq5Og5csNPrf
         e1DAY/+IfNt2d+xcfCjPGWCVjj2vQfUmpVgJnsJrRL4Iws4Kum+kiw/p2X2g40fP6etx
         i4RA==
X-Gm-Message-State: AMCzsaUU11ttl2NP7OLYBXxlryunMeLMlRMNs+0UbR4D4e7ArCr5v3mf
        UlPvtFRusn07E1/cj50yy4DGU7XcF58=
X-Google-Smtp-Source: ABhQp+QOvh4pSUDFmgC4PSyUIxfCI0rmzTm1s76DbYpD5R5tUOTon+cE0aW0STQbOOxKUvtKA0+P+w==
X-Received: by 10.99.6.75 with SMTP id 72mr5051509pgg.350.1508519958877;
        Fri, 20 Oct 2017 10:19:18 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m9sm2102877pgt.49.2017.10.20.10.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Oct 2017 10:19:17 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, spearce@spearce.org,
        git@jeffhostetler.com, gitster@pobox.com, jonathantanmy@google.com,
        jrnieder@gmail.com, peff@peff.net, sbeller@google.com
Subject: [RFC] protocol version 2
Date:   Fri, 20 Oct 2017 10:18:39 -0700
Message-Id: <20171020171839.4188-1-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.rc1.287.g2b38de12cc-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 Objective
===========

Replace Git's current wire protocol with a simpler, less wasteful
protocol that can evolve over time.

 Background
============

Git's wire protocol is the language used to clone/fetch/push from/to a
remote git repository.  A detailed explanation of the current protocol
spec can be found
[here](https://git.kernel.org/pub/scm/git/git.git/tree/Documentation/technical/pack-protocol.txt).
Some of the pain points with the current protocol spec are:

  * The server's initial response is the ref advertisement.  This
    advertisement cannot be omitted and can become an issue due to the
    sheer number of refs that can be sent with large repositories.  For
    example, when contacting the internal equivalent of
    `https://android.googlesource.com/`, the server will send
    approximately 1 million refs totaling 71MB.  This is data that is
    sent during each and every fetch and is not scalable.

  * Capabilities were implemented as a hack and are hidden behind a NUL
    byte after the first ref sent from the server during the ref
    advertisement:

	<SHA1> <Ref Name>\0<capabilities space separated> <symref> <agent>

    Since they are sent in the context of a pkt-line they are also subject
    to the same length limitations (1k bytes with old clients).  While we
    may not be close to hitting this limitation with capabilities alone, it
    has become a problem when trying to abuse capabilities for other
    purposes (e.g. [symrefs](https://public-inbox.org/git/20160816161838.klvjhhoxsftvkfmd@x/)).

  * Various other technical debt (e.g. abusing capabilities to
    communicate agent and symref data, service name set using a query
    parameter).

 Overview
==========

This document presents a specification for a version 2 of Git's wire
protocol.  Protocol v2 will improve upon v1 in the following ways:

  * Instead of multiple service names, multiple commands will be
    supported by a single service
  * Easily extendable as capabilities are moved into their own section
    of the protocol, no longer being hidden behind a NUL byte and
    limited by the size of a pkt-line (as there will be a single
    capability per pkt-line).
  * Separate out other information hidden behind NUL bytes (e.g. agent
    string as a capability and symrefs can be requested using 'ls-ref')
  * Ref advertisement will be omitted unless explicitly requested
  * ls-ref command to explicitly request some refs

 Detailed Design
=================

A client can request to speak protocol v2 by sending `version=2` in the
side-channel `GIT_PROTOCOL` in the initial request to the server.

In protocol v2 communication is command oriented.  When first contacting
a server a list of capabilities will advertised.  Some of these
capabilities will be commands which a client can request be executed.
Once a command has completed, a client can reuse the connection and
request that other commands be executed

 Special Packets
-----------------

In protocol v2 these special packets will have the following semantics:

  * '0000' Flush Packet (flush-pkt) - indicates the end of a message
  * '0001' End-of-List delimiter (delim-pkt) - indicates the end of a list

 Capability Advertisement
--------------------------

A server which decides to communicate (based on a request from a client)
using protocol version 2, notifies the client by sending a version
string in its initial response followed by an advertisement of its
capabilities.  Each capability is a key with an optional value.  Clients
must ignore all unknown keys.  Semantics of unknown values are left to
the definition of each key.  Some capabilities will describe commands
which can be requested to be executed by the client.

    capability-advertisement = protocol-version
                               capability-list
                               flush-pkt

    protocol-version = PKT-LINE("version 2" LF)
    capability-list = *capability
    capability = PKT-LINE(key[=value] LF)

    key = 1*CHAR
    value = 1*CHAR
    CHAR = 1*(ALPHA / DIGIT / "-" / "_")

A client then responds to select the command it wants with any
particular capabilities or arguments.  There is then an optional section
where the client can provide any command specific parameters or queries.

    command-request = command
                      capability-list
                      delim-pkt
                      (command specific parameters)
                      flush-pkt
    command = PKT-LINE("command=" key LF)

The server will then acknowledge the command and requested capabilities
by echoing them back to the client and then launch into the command.

    acknowledge-request = command
                          capability-list
                          delim-pkt
                          execute-command
    execute-command = <defined by each command>


A particular command can last for as many rounds as are required to
complete the service (multiple for negotiation during fetch and push or
no additional trips in the case of ls-refs).


 Commands in v2
~~~~~~~~~~~~~~~~

Services are the core actions that a client wants to perform (fetch,
push, etc).  Each service has its own set of capabilities and its own
language of commands (think 'want' lines in fetch).  Optionally a
service can take in initial parameters or data when a client sends it
service request.

 Ls-refs
---------

Ls-refs can be looked at as the equivalent of the current ls-remote as
it is a way to query a remote for the references that it has.  Unlike
the current ls-remote, the filtering of the output is done on the server
side by passing a number of parameters to the server-side command
instead of the filtering occurring on the client.

Ls-ref takes in the following parameters:

  --head, --tags: Limit to only refs/heads or refs/tags
  --refs: Do not show peeled tags or pseudorefs like HEAD
  --symref: In addition to the object pointed by it, show the underlying
            ref pointed by it when showing a symbolic ref
  <refspec>: When specified, only references matching the given patterns
             are displayed.

The output of ls-refs is as follows:

    output = (no-refs / list-of-refs)
	     *symref
             *shallow
             flush-pkt

    no-refs = PKT-LINE(zero-id SP no-refs LF)
    list-of-refs = *ref
    ref = PKT-LINE((tip / peeled) LF)
    tip = obj-id SP refname
    peeled = obj-id SP refname "^{}"

    symref = PKT-LINE("symref" SP symbolic-ref SP resolved-ref LF)
    shallow = PKT-LINE("shallow" SP obj-id LF)

 Fetch
-------

Fetch will need to be a modified version of the v1 fetch protocol.  Some
potential areas for improvement are: Ref-in-want, CDN offloading,
Fetch-options.

Since we'll have an 'ls-ref' service we can eliminate the need of fetch
to perform a ref-advertisement, instead a client can run the 'ls-refs'
service first, in order to find out what refs the server has, and then
request those refs directly using the fetch service.

//TODO Flush out the design

 Fetch-object
--------------

This service could be used by partial clones in order to request missing
objects.

//TODO Flush out the design

 Push
------

Push will need to be a modified version of the v1 push protocol.  Some
potential areas for improvement are: Fix push-options, Negotiation for
force push.

One change that will need to happen is to improve how `push-options` are
sent to the server (so that they aren't sent twice!!).  Also the
report-status needs to be better than it currently is in v1 so that
tools like gerrit can explain what it did with the ref-update the client
sent to it. Maybe have a push-rebase capability or command?

//TODO Flush out the design

 Other Considerations
======================

  * Move away from pkt-line framing?
  * Have responses structured in well known formats (e.g. JSON)
  * Eliminate initial round-trip using 'GIT_PROTOCOL' side-channel
  * Additional commands in a partial clone world (e.g. log, grep)
