Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BB5ECAAD8
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 19:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiIMT0D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 15:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIMT0B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 15:26:01 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA2B7287F
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 12:25:59 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t7so22322173wrm.10
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 12:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=Jcp9E3GsY65t14FujCjIaHXWb71hKtnXB9bFBdjXASo=;
        b=qjJ8pWWUYchAM/TvAskWAj+9NDbIVBdSCn/3ndlnQWcusulAUi9xTLGn1lY4ED+jcA
         9ap++DLhinhhaSEBsH60Yl6/L4GCh6cpzuBOdVGcTwfhgtxlJxMV8qxetHSiKBUKJeKF
         /h5S3jXEQA1e4tpcbPWvyI6RSXHQ+eDzHGlyN68Lll0vRK9axD8v3XXIrdXrEZR7E10m
         lU2t+Aqb6tt/n552m6XZlDN7fYlNqgMTSIdks0o0Dt/kSCam+/IINu1bQWrbbjlkv6bL
         SD6XTP0UaH2kzVB+DJPXNjIM63aLiUe81TMPcH9zaSCeNEQf0lPcHTL11jX7nijE9/Wa
         l7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Jcp9E3GsY65t14FujCjIaHXWb71hKtnXB9bFBdjXASo=;
        b=7eXWbsUfLixTUbtRxAMpxv0UOKRPGiWrovAONq38XNa5kz+OgqftsOFEhRbj9XO8L6
         vD4FaRSbYATLY61ltE0O76K12+ICe9rv3RcnvwcBoQB/R83sZmVj8+ias1eEev9zeS/u
         6pYqDzVcQQIwkDhUs/Ep17HDBKBKWzlymA2LGRBRHE2Rvv+SUb2UVjhmaRtW7+0P1hR9
         ci0kTBPKRW+4mmi99fHpGdcVRQSRetVZKMl1MHRDvs1bFjh0SMj+2I6ZqEJD0o42GVXl
         hZIgCTNyULKsUndHcxQF+cSqhIflZ3Gy4AVBk50DOIu/53uXc8yaGWGpGP2DPvSiJ0xV
         Cpew==
X-Gm-Message-State: ACgBeo29YOAFZe74xMUditfMOhJUwZKLfJZbeFMHFG1L531uBRZ7oYYi
        mOv6Uyae9ZRqskYD+6NAUr7T4vft2WI=
X-Google-Smtp-Source: AA6agR7VO3LruLc9n7ECk+RWH2cxOBk+MR+eCODV+aw6nSsevmi3119v4AhLVqPmwmEpFV8BL+1D9A==
X-Received: by 2002:a5d:6984:0:b0:228:de87:dd0a with SMTP id g4-20020a5d6984000000b00228de87dd0amr19733778wru.350.1663097157887;
        Tue, 13 Sep 2022 12:25:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m22-20020a05600c4f5600b003b47581979bsm12420525wmq.33.2022.09.13.12.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:25:57 -0700 (PDT)
Message-Id: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Sep 2022 19:25:48 +0000
Subject: [PATCH 0/8] [RFC] Enhance credential helper protocol to include auth headers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew John Cheetham <mjcheetham@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello! I have an RFC to update the existing credential helper design in
order to allow for some new scenarios, and future evolution of auth methods
that Git hosts may wish to provide. I outline the background, summary of
changes and some challenges below. I also attach a series of patches to
illustrate the design proposal.

One missing element from the patches are extensive tests of the new
behaviour. It appears existing tests focus either on the credential helper
protocol/format, or rely on testing basic authentication only via an Apache
webserver. In order to have a full end to end test coverage of these new
features it make be that we need a more comprehensive test bed to mock these
more nuanced authentication methods. I lean on the experts on the list for
advice here.


Background
==========

Git uses a variety of protocols [1]: local, Smart HTTP, Dumb HTTP, SSH, and
Git. Here I focus on the Smart HTTP protocol, and attempt to enhance the
authentication capabilities of this protocol to address limitations (see
below).

The Smart HTTP protocol in Git supports a few different types of HTTP
authentication - Basic and Digest (RFC 2617) [2], and Negotiate (RFC 2478)
[3]. Git uses a extensible model where credential helpers can provide
credentials for protocols [4]. Several helpers support alternatives such as
OAuth authentication (RFC 6749) [5], but this is typically done as an
extension. For example, a helper might use basic auth and set the password
to an OAuth Bearer access token. Git uses standard input and output to
communicate with credential helpers.

After a HTTP 401 response, Git would call a credential helper with the
following over standard input:

protocol=https
host=example.com


And then a credential helper would return over standard output:

protocol=https
host=example.com
username=bob@id.example.com
password=<BEARER-TOKEN>


Git then the following request to the remote, including the standard HTTP
Authorization header (RFC 7235 Section 4.2) [6]:

GET /info/refs?service=git-upload-pack HTTP/1.1
Host: git.example
Git-Protocol: version=2
Authorization: Basic base64(bob@id.example.com:<BEARER-TOKEN>)


Credential helpers are encouraged (see gitcredentials.txt) to return the
minimum information necessary.


Limitations
===========

Because this credential model was built mostly for password based
authentication systems, it's somewhat limited. In particular:

 1. To generate valid credentials, additional information about the request
    (or indeed the requestee and their device) may be required. For example,
    OAuth is based around scopes. A scope, like "git.read", might be
    required to read data from the remote. However, the remote cannot tell
    the credential helper what scope is required for this request.

 2. This system is not fully extensible. Each time a new type of
    authentication (like OAuth Bearer) is invented, Git needs updates before
    credential helpers can take advantage of it (or leverage a new
    capability in libcurl).


Goals
=====

 * As a user with multiple federated cloud identities:
   
   * Reach out to a remote and have my credential helper automatically
     prompt me for the correct identity.
   * Leverage existing authentication systems built-in to many operating
     systems and devices to boost security and reduce reliance on passwords.

 * As a Git host and/or cloud identity provider:
   
   * Leverage newest identity standards, enhancements, and threat
     mitigations - all without updating Git.
   * Enforce security policies (like requiring two-factor authentication)
     dynamically.
   * Allow integration with third party standard based identity providers in
     enterprises allowing customers to have a single plane of control for
     critical identities with access to source code.


Design Principles
=================

 * Use the existing infrastructure. Git credential helpers are an
   already-working model.
 * Follow widely-adopted time-proven open standards, avoid net new ideas in
   the authentication space.
 * Minimize knowledge of authentication in Git; maintain modularity and
   extensibility.


Proposed Changes
================

 1. Teach Git to read HTTP response headers, specifically the standard
    WWW-Authenticate (RFC 7235 Section 4.1) headers.

 2. Teach Git to include extra information about HTTP responses that require
    authentication when calling credential helpers. Specifically the
    WWW-Authenticate header information.
    
    Because the extra information forms an ordered list, and the existing
    credential helper I/O format only provides for simple key=value pairs,
    we introduce a new convention for transmitting an ordered list of
    values. Key names that are suffixed with a C-style array syntax should
    have values considered to form an order list, i.e. key[n]=value, where n
    is a zero based index of the values.
    
    For the WWW-Authenticate header values we opt to use the key wwwauth[n].

 3. Teach Git to specify authentication schemes other than Basic in
    subsequent HTTP requests based on credential helper responses.


Handling the WWW-Authenticate header in detail
==============================================

RFC 6750 [7] envisions that OAuth Bearer resource servers would give
responses that include WWW-Authenticate headers, for example:

HTTP/1.1 401 Unauthorized
WWW-Authenticate: Bearer realm="login.example", scope="git.readwrite"
WWW-Authenticate: Basic realm="login.example"


Specifically, a WWW-Authenticate header consists of a scheme and arbitrary
attributes, depending on the scheme. This pattern enables generic OAuth or
OpenID Connect [8] authorities. Note that it is possible to have several
WWW-Authenticate challenges in a response.

First Git attempts to make a request, unauthenticated, which fails with a
401 response and includes WWW-Authenticate header(s).

Next, Git invokes a credential helper which may prompt the user. If the user
approves, a credential helper can generate a token (or any auth challenge
response) to be used for that request.

For example: with a remote that supports bearer tokens from an OpenID
Connect [8] authority, a credential helper can use OpenID Connect's
Discovery [9] and Dynamic Client Registration [9] to register a client and
make a request with the correct permissions to access the remote. In this
manner, a user can be dynamically sent to the right federated identity
provider for a remote without any up-front configuration or manual
processes.

Following from the principle of keeping authentication knowledge in Git to a
minimum, we modify Git to add all WWW-Authenticate values to the credential
helper call.

Git sends over standard input:

protocol=https
host=example.com
wwwauth[0]=Bearer realm="login.example", scope="git.readwrite"
wwwauth[1]=Basic realm="login.example"


A credential helper that understands the extra wwwauth[n] property can
decide on the "best" or correct authentication scheme, generate credentials
for the request, and interact with the user.

The credential helper would then return over standard output:

protocol=https
host=example.com
path=foo.git
username=bob@identity.example
password=<BEARER-TOKEN>


Note that WWW-Authenticate supports multiple challenges, either in one
header:

HTTP/1.1 401 Unauthorized
WWW-Authenticate: Bearer realm="login.example", scope="git.readwrite", Basic realm="login.example"


or in multiple headers:

HTTP/1.1 401 Unauthorized
WWW-Authenticate: Bearer realm="login.example", scope="git.readwrite"
WWW-Authenticate: Basic realm="login.example"


These have equivalent meaning (RFC 2616 Section 4.2 [11]). To simplify the
implementation, Git will not merge or split up any of these WWW-Authenticate
headers, and instead pass each header line as one credential helper
property. The credential helper is responsible for splitting, merging, and
otherwise parsing these header values.

An alternative option to sending the header fields individually would be to
merge the header values in to one key=value property, for example:

...
wwwauth=Bearer realm="login.example", scope="git.readwrite", Basic realm="login.example"



Future flexibility
==================

By allowing the credential helpers decide the best authentication scheme, we
can allow the remote Git server to both offer new schemes (or remove old
ones) that enlightened credential helpers could take immediate advantage of,
and to use credentials that are much more tightly scoped and bound to the
specific request.

For example imagine a new "FooBar" authentication scheme that is surfaced in
the following response:

HTTP/1.1 401 Unauthorized
WWW-Authenticate: FooBar realm="login.example", algs="ES256 PS256"


With support for arbitrary authentication schemes, Git would call credential
helpers with the following over standard input:

protocol=https
host=example.com
wwwauth[0]=FooBar realm="login.example", algs="ES256 PS256", nonce="abc123"


And then an enlightened credential helper would return over standard output:

protocol=https
host=example.com
authtype=FooBar
username=bob@id.example.com
password=<FooBar credential>


Git would be expected to attach this authorization header to the next
request:

GET /info/refs?service=git-upload-pack HTTP/1.1
Host: git.example
Git-Protocol: version=2
Authorization: FooBar <FooBar credential>



Should Git not control the set of authentication schemes?
=========================================================

One concern that the reader may have regarding these changes is in allowing
helpers to select the authentication mechanism to use, it may be possible
that a weaker form of authentication is used.

Take for example a Git remote server that responds with the following
authentication schemes:

HTTP/1.1 401 Unauthorized
WWW-Authenticate: Negotiate ...
WWW-Authenticate: Basic ...


Today Git (and libcurl) prefer to Negotiate over Basic authentication [12].
If a helper responded with authtype=basic Git would now be using a "less
secure" mechanism.

The reason we still propose the credential helper decide on the
authentication scheme is that Git is not the best placed entity to decide
what type of authentication should be used for a particular request (see
Design Principle 3).

OAuth Bearer tokens are often bundled in Basic Authorization headers [13],
but given that the tokens are/can be short-lived and have a highly scoped
set of permissions, this solution could be argued as being more secure than
something like NTLM [14]. Similarly, the user may wish to be consulted on
selecting a particular user account, or directly selecting an authentication
mechanism for a request that otherwise they would not be able to use.

Also, as new authentication protocols appear Git does not need to be
modified or updated for the user to take advantage of them; the credential
helpers take on the responsibility of learning and selecting the "best"
option.


Why not SSH?
============

There's nothing wrong with SSH. However, Git's Smart HTTP transport is
widely used, often with OAuth Bearer tokens. Git's Smart HTTP transport
sometimes requires less client setup than SSH transport, and works in
environments when SSH ports may be blocked. As long as Git supports HTTP
transport, it should support common and popular HTTP authentication methods.


References
==========

 * [1] Git on the Server - The Protocols
   https://git-scm.com/book/en/v2/Git-on-the-Server-The-Protocols

 * [2] HTTP Authentication: Basic and Digest Access Authentication
   https://datatracker.ietf.org/doc/html/rfc2617

 * [3] The Simple and Protected GSS-API Negotiation Mechanism
   https://datatracker.ietf.org/doc/html/rfc2478

 * [4] Git Credentials - Custom Helpers
   https://git-scm.com/docs/gitcredentials#_custom_helpers

 * [5] The OAuth 2.0 Authorization Framework
   https://datatracker.ietf.org/doc/html/rfc6749

 * [6] Hypertext Transfer Protocol (HTTP/1.1): Authentication
   https://datatracker.ietf.org/doc/html/rfc7235

 * [7] The OAuth 2.0 Authorization Framework: Bearer Token Usage
   https://datatracker.ietf.org/doc/html/rfc6750

 * [8] OpenID Connect Core 1.0
   https://openid.net/specs/openid-connect-core-1_0.html

 * [9] OpenID Connect Discovery 1.0
   https://openid.net/specs/openid-connect-discovery-1_0.html

 * [10] OpenID Connect Dynamic Client Registration 1.0
   https://openid.net/specs/openid-connect-registration-1_0.html

 * [11] Hypertext Transfer Protocol (HTTP/1.1)
   https://datatracker.ietf.org/doc/html/rfc2616

 * [12] libcurl http.c pickoneauth Function
   https://github.com/curl/curl/blob/c495dcd02e885fc3f35164b1c3c5f72fa4b60c46/lib/http.c#L381-L416

 * [13] Git Credential Manager GitHub Host Provider (using PAT as password)
   https://github.com/GitCredentialManager/git-credential-manager/blob/f77b766f6875b90251249f2aa1702b921309cf00/src/shared/GitHub/GitHubHostProvider.cs#L157

 * [14] NT LAN Manager (NTLM) Authentication Protocol
   https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-nlmp/b38c36ed-2804-4868-a9ff-8dd3182128e4

Matthew John Cheetham (8):
  wincred: ignore unknown lines (do not die)
  netrc: ignore unknown lines (do not die)
  osxkeychain: clarify that we ignore unknown lines
  http: read HTTP WWW-Authenticate response headers
  credential: add WWW-Authenticate header to cred requests
  http: store all request headers on active_request_slot
  http: move proactive auth to first slot creation
  http: set specific auth scheme depending on credential

 Documentation/git-credential.txt              |  18 ++
 .../netrc/git-credential-netrc.perl           |   5 +-
 .../osxkeychain/git-credential-osxkeychain.c  |   5 +
 .../wincred/git-credential-wincred.c          |   7 +-
 credential.c                                  |  18 ++
 credential.h                                  |  11 +
 git-curl-compat.h                             |   7 +
 http-push.c                                   | 103 ++++-----
 http-walker.c                                 |   2 +-
 http.c                                        | 199 +++++++++++++-----
 http.h                                        |   4 +-
 remote-curl.c                                 |  36 ++--
 t/lib-httpd/apache.conf                       |  13 ++
 t/t5551-http-fetch-smart.sh                   |  46 ++++
 14 files changed, 335 insertions(+), 139 deletions(-)


base-commit: dd3f6c4cae7e3b15ce984dce8593ff7569650e24
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1352%2Fmjcheetham%2Femu-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1352/mjcheetham/emu-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1352
-- 
gitgitgadget
